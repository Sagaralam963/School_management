using school as s from '../db/schema';

service ScoolService  {

    entity Student as projection on s.Student;

}