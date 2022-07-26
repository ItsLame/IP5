"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.handleRequestEvent = void 0;
function handleRequestEvent(contract, grabData) {
    contract.events["request(uint256,address,bytes)"]()
        .on("connected", function (subscriptionId) {
        console.log("listening on event 'request'" + ", subscriptionId: " + subscriptionId);
    })
        .on('data', function (event) {
        let caller = event.returnValues.caller;
        let requestId = event.returnValues.requestId;
        let data = event.returnValues.data;
        grabData(caller, requestId, data);
    })
        .on('error', function (error, receipt) {
        console.log(error);
        console.log(receipt);
        console.log("error listening on event 'request'");
    });
}
exports.handleRequestEvent = handleRequestEvent;
