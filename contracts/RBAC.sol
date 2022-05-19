// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/AccessControl.sol";

import "contracts/Government.sol";
import "contracts/Hospital.sol";
import "contracts/Doctor.sol";
import "contracts/Patient.sol";
import "hardhat/console.sol";

contract ROLE_BASED_ACCESS is AccessControl {
    bytes32 public constant GOVERNMENT = keccak256("GOVERNMENT");
    bytes32 public constant PATIENT = keccak256("PATIENT");
    bytes32 public constant HOSPITAL = keccak256("HOSPITAL");
    bytes32 public constant DOCTOR = keccak256("DOCTOR");

    constructor() {
        _setupRole("GOVERNMENT", msg.sender);
        _setRoleAdmin("GOVERNMENT", "GOVERNMENT");
        _setRoleAdmin("PATIENT", "GOVERNMENT");
        _setRoleAdmin("HOSPITAL", "GOVERNMENT");
        _setRoleAdmin("DOCTOR", "GOVERNMENT");
    }

    function setContracts(address _address) public {
        grantRole("GOVERNMENT", _address);
    }

    function grantRoleAccessControl(bytes32 _role, address _address) public {
        grantRole(_role, _address);
    }

    function setUpRoleAccessControl(bytes32 _role, address _address) public {
        _setupRole(_role, _address);
    }

    function setUpRoleAdminAccessControl(bytes32 _role, bytes32 _roleAdmin)
        public
    {
        _setRoleAdmin(_role, _roleAdmin);
    }

    function isGovernment(address _GID) public view returns (bool) {
        return (hasRole("GOVERNMENT", _GID));
    }

    function isPatient(address _GID) public view returns (bool) {
        return (hasRole("PATIENT", _GID));
    }

    function isHospital(address _GID) public view returns (bool) {
        return (hasRole("HOSPITAL", _GID));
    }

    function isDoctor(address _GID) public view returns (bool) {
        return (hasRole("DOCTOR", _GID));
    }

    function _onlyGoverment() private view {
        require(
            hasRole("GOVERNMENT", tx.origin),
            "Restricted to users."
        );
    }

    function _onlyPatient() private view {
        require(
            hasRole("PATIENT", tx.origin),
            "Restricted to PATIENT."
        );
    }


    function _onlyDoctor() private view {
        require(
            hasRole("DOCTOR", tx.origin),
            "Restricted to DOCTOR."
        );
    }


    function _onlyHospital() private view {
        require(
            hasRole("HOSPITAL", tx.origin),
            "Restricted to HOSPITAL."
        );
    }
}