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
        address candidateAddress;
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

    enum VotingStatus {
        NotStarted,
        InProgress,
        Ended
    }
    enum Gender {
        NotSpecified,
        Male,
        Female,
        Other
    }

    constructor() {
        // Election commission will be the person who will deploy this smart contract.
        // Constructor runs as soon as we will deploy this smart contract.
        electionCommission = msg.sender;
    }

    modifier isVotingOver() {
        require(
            block.timestamp > endTime || stopVoting == true,
            "Voting is not over!!"
        );
        _;
    }

    modifier onlyCommissioner() {
        require(msg.sender == electionCommission, "Not authorized");
        _;
    }

    function registerCandidate(
        string calldata _name,
        string calldata _party,
        uint _age,
        Gender _gender
    ) external {
        candidateDetails[nextCandidateId] = Candidate({
            name: _name,
            party: _party,
            age: _age,
            gender: _gender,
            candidateId: nextCandidateId,
            candidateAddress: msg.sender,
            votes: 0
        });
        nextCandidateId++;
    }
}
