const cds = require('@sap/cds');
const { SELECT } = require('@sap/cds/lib/ql/cds-ql');

module.exports = async (srv) => {

    const {Student} = srv.entities;

srv.before('CREATE', 'Student', async(req) => {

    const tx = cds.tx(req);

    const maxRow = await tx.run(
      SELECT.one.from(Student).columns`max(admissionNo) as Max_AdmissionNo`
    );

    console.log(maxRow);

    const next_AdmissionNo = maxRow.Max_AdmissionNo + 1;

    console.log("next_AdmissionNo : ",next_AdmissionNo);

    req.data.admissionNo = next_AdmissionNo;

    return req.data;
})

}