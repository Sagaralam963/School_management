sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"ns/schoolmanagement/test/integration/pages/StudentList",
	"ns/schoolmanagement/test/integration/pages/StudentObjectPage"
], function (JourneyRunner, StudentList, StudentObjectPage) {
    'use strict';

    var runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('ns/schoolmanagement') + '/test/flp.html#app-preview',
        pages: {
			onTheStudentList: StudentList,
			onTheStudentObjectPage: StudentObjectPage
        },
        async: true
    });

    return runner;
});

