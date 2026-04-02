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

    modifier isValidAge(uint _age) {
        require(_age >= 18, "You are below 18");
        _;
    }

    function registerCandidate(
        string calldata _name,
        string calldata _party,
        uint _age,
        Gender _gender
    ) external isValidAge(_age) {
        require(
            isCandidateNotRegistered(msg.sender),
            "You are already registered"
        );
        require(nextCandidateId < 3, "Candidate registration full");
        require(
            msg.sender != electionCommission,
            "Election commission not allowed"
        );

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

    function registerVoter(
        string calldata _name,
        uint _age,
        Gender _gender
    ) external isValidAge(_age) {
        require(isVoterNotRegistered(msg.sender), "You are already registered");

        voterDetails[nextVoterId] = Voter({
            name: _name,
            age: _age,
            gender: _gender,
            voterId: nextVoterId,
            voterAddress: msg.sender,
            voteCandidateId: 0
        });
        nextVoterId++;
    }

    function isCandidateNotRegistered(
        address _person
    ) internal view returns (bool) {
        for (uint i = 1; i < nextCandidateId; i++) {
            if (candidateDetails[i].candidateAddress == _person) {
                return false;
            }
        }
        return true;
    }

    function isVoterNotRegistered(
        address _person
    ) internal view returns (bool) {
        for (uint i = 1; i < nextVoterId; i++) {
            if (voterDetails[i].voterAddress == _person) {
                return false;
            }
        }
        return true;
    }

    function getVoterList() public view returns (Voter[] memory) {
        Voter[] memory voterList = new Voter[](nextVoterId - 1);
        for (uint i = 0; i < voterList.length; i++) {
            voterList[i] = voterDetails[i + 1];
        }
        return voterList;
    }

    function getCandidateList() public view returns (Candidate[] memory) {
        Candidate[] memory candidateList = new Candidate[](nextCandidateId - 1);
        for (uint i = 0; i < candidateList.length; i++) {
            candidateList[i] = candidateDetails[i + 1];
        }
        return candidateList;
    }

    function castVote(uint _voterId, uint _candidateId) external {
        require(voterDetails[_voterId].voteCandidateId == 0, "You have already voted");
        require(voterDetails[_voterId].voterAddress == msg.sender, "You are not authorized");
        require(_candidateId >= 1 && _candidateId < 3, "Candidate Id is not correct");

        voterDetails[_voterId].voteCandidateId = _candidateId;
        candidateDetails[_candidateId].votes++;
    }

     function setVotingPeriod(uint _startTime, uint _endTime) external onlyCommissioner() {
        require(_startTime < _endTime, "Invalid time period");
        require(_endTime > 3600, "Time range must be greater than 1 hour");

        startTime = block.timestamp + _startTime;
        endTime = startTime + _endTime;
    }

    function getVotingStatus() external view returns(VotingStatus) {
        if (startTime == 0) {
            return VotingStatus.NotStarted;
        } else if (endTime > block.timestamp && stopVoting == false) {
            return VotingStatus.InProgress;
        } else {
            return VotingStatus.Ended;
        }
    }

    function announceVotingResult() external onlyCommissioner() returns(address) {
        if(candidateDetails[1].votes > candidateDetails[2].votes) {
            winner = candidateDetails[1].candidateAddress;
        } else {
            winner = candidateDetails[2].candidateAddress;
        }
        return winner;
    }

    function emergencyStopVoting() public onlyCommissioner() {
        stopVoting = true;
    }
}
