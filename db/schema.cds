namespace school;

using {
  managed,
  cuid
} from '@sap/cds/common';


@cds.persistence.schema: 'SCHOOL' // helpful for HANA
type Gender : String(1) enum {
  M = 'M'; // Male
  F = 'F'; // Female
  O = 'O'; // Other/Prefer not to say
}

entity Student : managed {
  key admissionNo   : Integer;
      admissionYear : String(4);
      firstName     : String(100);
      middleName    : String(100);
      lastName      : String(100);
      class         : Integer;
      section       : String(5);
      age           : Integer;
      gender        : Gender;
      dob           : Date;
      guardianName  : String(150);
      contactNo     : String(15); // <<-- recommended
      address       : String(255);
      city          : String(100);
      Active        : Boolean default true;
}

// Master entity to drive the LR (unique Class + Section)
entity ClassSection {
  key class    : Integer;
  key section  : String(5);

      // Association to all students in this class-section
      students : Association to many Student
                   on  students.class   = $self.class
                   and students.section = $self.section;
}
