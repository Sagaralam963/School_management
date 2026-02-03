namespace school;

using { cuid, managed } from '@sap/cds/common';

@cds.persistence.schema: 'SCHOOL' // optional: helpful for HANA later
type Gender : String(1) enum {
  M = 'M'; // Male
  F = 'F'; // Female
  O = 'O'; // Other/Prefer not to say
}

// Academic year master, e.g., "2025-26"
entity AcademicYears : cuid, managed {
  @assert.unique
  code      : String(9); // e.g., '2025-26'
  startDate : Date;
  endDate   : Date;
  isActive  : Boolean default true;

  // Deep-insert friendly: a year can contain many class offerings
  classes   : Composition of many ClassOfferings
                on classes.year = $self;
}

// Standard/Grade master (e.g., Grade 1..12)
entity Standards : cuid, managed {
  @assert.unique
  name    : String(30); // e.g., 'Grade 1'
  orderNo : Integer;    // sort order
  classes : Association to many ClassOfferings
              on classes.standard = $self;
}

// Section master (A, B, C, …)
entity Sections : cuid {
  @assert.unique
  name : String(5); // e.g., 'A'
}

// Student master (independent of class; students can transfer across years)
entity Students : cuid, managed {
  @assert.unique
  admissionNo  : String(20); // school-wide unique
  firstName    : String(60);
  middleName   : String(60);
  lastName     : String(60);
  dob          : Date;
  gender       : Gender;
  guardianName : String(100);
  contactNo    : String(20);
  address      : String(200);
  city         : String(60);
  active       : Boolean default true;
}

// A specific class/section offered in a specific year
entity ClassOfferings : cuid, managed {
  year         : Association to AcademicYears not null;
  standard     : Association to Standards not null;
  section      : Association to Sections not null;
  classTeacher : String(100);

  // Deep insert: a class holds enrollments (but students remain independent)
  enrollments  : Composition of many Enrollments
                   on enrollments.class = $self;
}

// Enrollment of a student into a class (in a particular year)
// NOTE: Use association elements in the unique constraint, not *_ID

@cds.persistence.indexes: [
  { name: 'UQ_Enrollments_Class_Student', unique: true, columns: ['class_ID','student_ID'] }
]
entity Enrollments : cuid, managed {
  class    : Association to ClassOfferings not null;
  student  : Association to Students       not null;
  rollNo   : Integer; // can be made unique per class via another index (see below)
  joinedOn : Date;
  leftOn   : Date;
  status   : String(12) enum { Enrolled; Transferred; Graduated; Dropped; } default 'Enrolled';
}


/* -----------------------
   Analytical Views
   ----------------------- */

// Live per-class stats: strength, male, female, other


view ClassStats as
  select from ClassOfferings as c
    left join Enrollments as e on e.class.ID = c.ID
    left join Students    as s on e.student.ID = s.ID
  {
    c.ID              as classID,
    c.year.ID         as yearID,
    c.year.code       as yearCode,
    c.standard.ID     as standardID,
    c.standard.name   as standardName,
    c.section.ID      as sectionID,
    c.section.name    as sectionName,

    // Strength & gender splits only for active enrollments
    sum(case when e.status = 'Enrolled' and s.ID is not null then 1 else 0 end) as studentStrength,
    sum(case when e.status = 'Enrolled' and s.gender = 'M' then 1 else 0 end)   as maleCount,
    sum(case when e.status = 'Enrolled' and s.gender = 'F' then 1 else 0 end)   as femaleCount,
    sum(case when e.status = 'Enrolled' and s.gender = 'O' then 1 else 0 end)   as otherCount
  }
  group by
    c.ID,
    c.year.ID,
    c.year.code,
    c.standard.ID,
    c.standard.name,
    c.section.ID,
    c.section.name;



// Roll-up by Year + Standard (across sections)
view YearStandardStats as
  select from ClassStats {
    yearID,
    yearCode,
    standardID,
    standardName,
    sum(studentStrength) as studentStrength,
    sum(maleCount)       as maleCount,
    sum(femaleCount)     as femaleCount,
    sum(otherCount)      as otherCount
  }
  group by
    yearID,
    yearCode,
    standardID,
    standardName;

// Roll-up by Year (all standards/sections)
view YearStats as
  select from ClassStats {
    yearID,
    yearCode,
    sum(studentStrength) as studentStrength,
    sum(maleCount)       as maleCount,
    sum(femaleCount)     as femaleCount,
    sum(otherCount)      as otherCount
  }
  group by
    yearID,
    yearCode;