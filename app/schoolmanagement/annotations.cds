using ScoolService as service from '../../srv/cat-service';
annotate service.Student with @(
    UI.FieldGroup #GeneratedGroup : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Label : 'admissionNo',
                Value : admissionNo,
            },
            {
                $Type : 'UI.DataField',
                Label : 'admissionYear',
                Value : admissionYear,
            },
            {
                $Type : 'UI.DataField',
                Label : 'firstName',
                Value : firstName,
            },
            {
                $Type : 'UI.DataField',
                Label : 'middleName',
                Value : middleName,
            },
            {
                $Type : 'UI.DataField',
                Label : 'lastName',
                Value : lastName,
            },
            {
                $Type : 'UI.DataField',
                Label : 'class',
                Value : class,
            },
            {
                $Type : 'UI.DataField',
                Label : 'section',
                Value : section,
            },
            {
                $Type : 'UI.DataField',
                Label : 'age',
                Value : age,
            },
            {
                $Type : 'UI.DataField',
                Label : 'gender',
                Value : gender,
            },
            {
                $Type : 'UI.DataField',
                Label : 'dob',
                Value : dob,
            },
            {
                $Type : 'UI.DataField',
                Label : 'guardianName',
                Value : guardianName,
            },
            {
                $Type : 'UI.DataField',
                Label : 'contactNo',
                Value : contactNo,
            },
            {
                $Type : 'UI.DataField',
                Label : 'address',
                Value : address,
            },
            {
                $Type : 'UI.DataField',
                Label : 'city',
                Value : city,
            },
            {
                $Type : 'UI.DataField',
                Label : 'Active',
                Value : Active,
            },
        ],
    },
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'GeneratedFacet1',
            Label : 'General Information',
            Target : '@UI.FieldGroup#GeneratedGroup',
        },
    ],
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Label : 'admissionNo',
            Value : admissionNo,
        },
        {
            $Type : 'UI.DataField',
            Label : 'admissionYear',
            Value : admissionYear,
        },
        {
            $Type : 'UI.DataField',
            Label : 'firstName',
            Value : firstName,
        },
        {
            $Type : 'UI.DataField',
            Label : 'middleName',
            Value : middleName,
        },
        {
            $Type : 'UI.DataField',
            Label : 'lastName',
            Value : lastName,
        },
    ],
);

