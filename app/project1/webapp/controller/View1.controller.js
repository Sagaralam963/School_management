sap.ui.define([
    "sap/ui/core/mvc/Controller"
], (Controller) => {
    "use strict";

    return Controller.extend("project1.controller.View1", {
        onInit() {
        },

        onClick: async function (oEvent) {

            let href = window.location.href.split('sap')[0];
            let url = href + "sap/odata/v4/school/getClassCout";

            const oPayload = {
                "className": 1
            };


            const response = await fetch(url, {
                method: "POST",
                headers: {
                    "Content-Type": "application/json"
                },
                body: JSON.stringify(oPayload)
            });

            if (!response.ok) {
                throw new Error("Network response was not ok");
            }

            const oData = await response.json();

            console.log(oData);

        },
    });
});