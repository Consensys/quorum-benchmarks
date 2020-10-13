/*
* Licensed under the Apache License, Version 2.0 (the "License");
* you may not use this file except in compliance with the License.
* You may obtain a copy of the License at
*
* http://www.apache.org/licenses/LICENSE-2.0
*
* Unless required by applicable law or agreed to in writing, software
* distributed under the License is distributed on an "AS IS" BASIS,
* WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
* See the License for the specific language governing permissions and
* limitations under the License.
*/


'use strict';

module.exports.info = 'registering people';

let bc, contx;
//let account_array;
//let initmoney;

//  function register(bytes32 hash, bytes32 subjectId, uint startDate, uint exp, Sex sex, uint8 age, bytes6 geoHash, CovidCode credentialType, InterruptionReason reason) onlyWhitelisted external returns(bool) {
//    CovidMetadata storage credential = credentials[hash][msg.sender];
//    require(credential.subjectId==0,"Credential ID already exists");
//
//    credential.subjectId = subjectId;
//    credential.startDate = startDate;
//    credential.iat = now*1000;
//    credential.exp = exp;
//    credential.sex = sex;
//    credential.age = age;
//    credential.geoHash = geoHash;
//    credential.credentialType = credentialType;
//    credential.reason = reason;
//    credential.status = true;
//    credentials[hash][msg.sender] = credential;
//    emit CredentialRegistered(hash, msg.sender, subjectId, startDate, credential.iat, sex, geoHash, credentialType, reason);
//    return true;
//  }



module.exports.init = async function (blockchain, context, args) {
    bc = blockchain;
    contx = context;

    let whitelistContext = {
      ... contx
    }
    
    whitelistContext.fromAddress = contx.contractDeployerAddress;

    let initializeArgs = [{
      verb: "initialize",
      args: [
        whitelistContext.fromAddress
      ]
    }];

    try {
      await bc.invokeSmartContract(whitelistContext, 'covid', 'v0', initializeArgs, 10);
    } catch {
      // no worries if this fails - it means that the contract has already been intialized
    }

    let whitelistArgs = [{
      verb: "addWhitelisted",
      args: [
        contx.fromAddress
      ]
    }];

    return bc.invokeSmartContract(whitelistContext, 'covid', 'v0', whitelistArgs, 10);
};

let credentialId = 1;

module.exports.run = function () {
    let args;

    let hash = Buffer.alloc(32, `${credentialId}`, "utf8"); // bytes32
  //credentialId++; // must be kept unique
    let subjectId = Buffer.from([0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]); // bytes32
    let startDate = (new Date()).getTime(); // uint
    let exp = 1; // uint
    let sex = 1; // struct Sex - likely will fail
    let age = 15; // uint8
    let geoHash = Buffer.from([0,0,0,0,0,1]); // bytes6
    let credentialType = 0; // struct CovidCode - likely will fail
    let reason = 0; // struct InterruptionReason - likely will fail

    if (bc.getType() === 'fabric') {
        args = {
            chaincodeFunction: 'register',
            chaincodeArguments: [hash, subjectId, startDate, exp, sex, age, geoHash, credentialType, reason],
        };
    } else if (bc.getType() === 'ethereum') {
        args = {
            verb: 'register',
            args: [hash, subjectId, startDate, exp, sex, age, geoHash, credentialType, reason]
        };
    } else {
        args = {
            'verb': 'register',
            'hash': hash,
            'subjectId': subjectId,
            'startDate': startDate,
            'exp': exp,
            'sex': sex,
            'age': age,
            'geoHash': geoHash,
            'credentialType': credentialType,
            'reason': reason
        };
    }

    //not sure what 10 or 'v0' is
    return bc.invokeSmartContract(contx, 'covid', 'v0', args, 10);

};

module.exports.end = function () {
    // do nothing
    return Promise.resolve();
};
