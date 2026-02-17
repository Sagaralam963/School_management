const cds = require('@sap/cds');
const { SELECT } = require('@sap/cds/lib/ql/cds-ql');

module.exports = async (srv) => {



  const { Student,ClassSections } = srv.entities;

  const BP = await cds.connect.to("API_BUSINESS_PARTNER");


  srv.before('CREATE', 'Student', async (req) => {

    const tx = cds.tx(req);

    const maxRow = await tx.run(
      SELECT.one.from(Student).columns`max(admissionNo) as Max_AdmissionNo`
    );

    console.log(maxRow);

    if (maxRow.Max_AdmissionNo == null) {

      const next_AdmissionNo = 1200001;

      console.log("next_AdmissionNo : ", next_AdmissionNo);

      req.data.admissionNo = next_AdmissionNo;

    } else {

      const next_AdmissionNo = maxRow.Max_AdmissionNo + 1;

      console.log("next_AdmissionNo : ", next_AdmissionNo);

      req.data.admissionNo = next_AdmissionNo;

    }



    return req.data;
  });

  
  srv.on('getClassCout', async (req)=> {

    const { className } = req.data;
    
    const tx = cds.tx(req);

    const data = await tx.run(
      SELECT.from (ClassSections).where({class:className})
    )
    console.log('ClassSections data : ',data);
     console.log('ClassSections count : ',data.length);

     return {
      data : data,
      class1_count : data.length
     }

  });


srv.on('READ', 'A_BusinessPartner', async(req)=>{

  return BP.run(req.query);
  
})

}