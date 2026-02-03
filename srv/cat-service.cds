using school as school from '../db/schema';

service SchoolService {

    // Masters & transactions
    entity AcademicYears     as projection on school.AcademicYears;
    entity Standards         as projection on school.Standards;
    entity Sections          as projection on school.Sections;
    entity Students          as projection on school.Students;
    entity ClassOfferings    as projection on school.ClassOfferings;
    entity Enrollments       as projection on school.Enrollments;

    // Analytics
    entity ClassStats        as projection on school.ClassStats;
    entity YearStandardStats as projection on school.YearStandardStats;
    entity YearStats         as projection on school.YearStats;

    // Example actions (optional – implement in handlers if needed)
    action transferStudent(studentID: UUID,
                           fromClass: UUID,
                           toClass: UUID,
                           effective: Date) returns Boolean;

    action closeYear(yearID: UUID)          returns Boolean;
}
