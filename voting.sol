// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18; // stating our version

contract Vote {
    struct Voter {
        string name;
        uint age;
        uint voterId;
        Gender gender;
        uint voteCandidateId; // candidate id to whom the voter has voted
        address voterAddress;
    }

    struct Candidate {
        string name;
        string party;
        uint age;
        Gender gender;
        uint candidateId;
        address candidateAdress;
        uint votes;
    }
}
