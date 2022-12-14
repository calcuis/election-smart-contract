# election-smart-contract
An example of election smart contract:

```
//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.9.0;

contract Election{ 
    struct Candidate{
        string name; 
        uint numVotes; 
    }

    struct Voter{
        string name; 
        bool authorised; 
        uint whom;
        bool voted; 
    }

    address public owner; 
    string public electionName; 

    mapping(address => Voter) public voters; 
    Candidate[] public candidates; 
    uint public totalVotes; 

    modifier ownerOnly(){ 
        require(msg.sender == owner); 
        _;
    }

    function startElection(string memory _electionName) public{ 
        owner = msg.sender; 
        electionName = _electionName; 
    }

    function addCandidate(string memory _candidateName ) ownerOnly public{ 
        candidates.push(Candidate(_candidateName, 0));
    }

    function authorizeVoter(address _voterAddress) ownerOnly public{ 
        voters[_voterAddress].authorised= true; 
    }

    function getNumCandidates() public view returns(uint){ 
        return candidates.length; 
    }

    function vote(uint candidateIndex) public{ 
        require(!voters[msg.sender].voted); 
        require(voters[msg.sender].authorised); 
        voters[msg.sender].whom = candidateIndex; 
        voters[msg.sender].voted = true; 

        candidates[candidateIndex].numVotes++; 
        totalVotes++;
    }

    function getTotalVotes()public view returns(uint) {
        return totalVotes;
    }

function candidateInfo(uint index) public view returns(Candidate memory){ 
        return candidates[index];
    }

}
```

This appears to be a smart contract for an election. The contract defines two structs: `Candidat`e and `Voter`. `Candidate` has two fields: `name`, a string representing the name of the candidate, and `numVotes`, a uint (unsigned integer) representing the number of votes the candidate has received. `Voter` has three fields: `name`, a string representing the voter's name, `authorised`, a bool representing whether the voter is authorized to vote, and `voted`, a bool representing whether the voter has already cast their vote.

The contract has a few different functions that can be called by users: `startElection()`, `addCandidate()`, `authorizeVoter()`, `vote()`, `getTotalVotes()`, and `candidateInfo()`. `startElection()` sets the owner of the contract to the user calling the function and sets the name of the election. `addCandidate()` adds a candidate to the election. `authorizeVoter()` authorizes a user to vote in the election. `vote()` allows an authorized user to cast their vote for a candidate. `getTotalVotes()` returns the total number of votes that have been cast in the election. `candidateInfo()` returns information about a specific candidate.

There are a few different modifiers in the contract that are used to control access to certain functions. The `ownerOnly` modifier is used on the `addCandidate()` and `authorizeVoter()` functions, which means that only the owner of the contract can call these functions. The `require()` statements in the `vote()` function also ensure that only authorized voters who have not yet voted can cast their vote.
