// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18; // stating our version

contract Vote {
    // First entity
    struct Voter {
        string name;
        uint age;
        uint voterId;
        Gender gender;
        uint voteCandidateId; // candidate id to whom the voter has voted
        address voterAddress;
    }

    // second entity
    struct Candidate {
        string name;
        string party;
        uint age;
        Gender gender;
        uint candidateId;
        address candidateAdress;
        uint votes;
    }

    // third entity
    address electionCommission;

    address public winner;

    uint nextVoterId = 1;
    uint nextCandidateId = 1;

    // voting period
    uint startTime;
    uint endTime;
    bool stopVoting;

    mapping(uint => Voter) voterDetails; // mapping of voterId -> Voter struct
    mapping(uint => Candidate) candidateDetails; // mapping of candidateId -> Candidate struct
}
