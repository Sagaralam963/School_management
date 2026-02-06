namespace school;

using {
  managed,
  cuid
} from '@sap/cds/common';


@cds.persistence.schema: 'SCHOOL' // optional: helpful for HANA later
type Gender : String(1) enum {
  M = 'M'; // Male
  F = 'F'; // Female
  O = 'O'; // Other/Prefer not to say
}

entity Student : managed {

  key admissionNo   : Integer;
      admissionYear : String;
      firstName     : String;
      middleName    : String;
      lastName      : String;
      class         : Integer;
      section       : String;
      age           : Integer;
      gender        : Gender;
      dob           : Date;
      guardianName  : String;
      contactNo     : Integer;
      address       : String;
      city          : String;
      Active        : Boolean default true;

}
