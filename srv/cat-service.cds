using school as s from '../db/schema';

service ScoolService  {

    entity Student as projection on s.Student;
    entity ClassData as projection on s.ClassData;

}