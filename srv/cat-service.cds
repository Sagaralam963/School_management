using school as s from '../db/schema';

using {API_BUSINESS_PARTNER as S4} from './external/API_BUSINESS_PARTNER';

using {managed} from '@sap/cds/common';


service SchoolService {
  entity Student       as projection on s.Student;
  entity ClassSections as projection on s.ClassSection;

  action getClassCout(className: Integer) returns String;


}

service BusinessParnerService {

  entity A_BusinessPartner as
    projection on S4.A_BusinessPartner {
      key BusinessPartner,
          Customer,
          BusinessPartnerFullName,
          BusinessPartnerGrouping,
          BusinessPartnerUUID,
          OrganizationBPName1
    }

}
