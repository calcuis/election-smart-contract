//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

contract Election { 
    struct Candidate{
        string name; 
        uint countVotes; 
    }

    struct Voter{
        string name; 
        bool authorised; 
        uint whom;
        bool voted; 
    }

    address public owner;

    mapping(address => Voter) public voters; 
    Candidate[] public candidates; 
    uint public totalVotes; 
    
    constructor() {
        owner = msg.sender;
    }

    function addCandidate(string memory _candidateName) public { 
        require(msg.sender == owner, "OwnerOnly");
        candidates.push(Candidate(_candidateName, 0));
    }

    function addVoter(address _voterAddress) public { 
        require(msg.sender == owner, "OwnerOnly");
        voters[_voterAddress].authorised= true; 
    }

    function removeVoter(address _voterAddress) public { 
        require(msg.sender == owner, "OwnerOnly");
        voters[_voterAddress].authorised= false; 
    }
    
    function vote(uint _id) public { 
        require(!voters[msg.sender].voted); 
        require(voters[msg.sender].authorised); 
        voters[msg.sender].whom = _id; 
        voters[msg.sender].voted = true; 

        candidates[_id].countVotes++; 
        totalVotes++;
    }

    function getTotalCandidates() public view returns(uint) { 
        return candidates.length; 
    }

    function getTotalVotes()public view returns(uint) {
        return totalVotes;
    }

    function getCandidate(uint _id) public view returns(Candidate memory){ 
        return candidates[_id];
    }

}
