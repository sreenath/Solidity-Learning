pragma solidity ^0.4.0;

contract Ballot {
    
    // Proposal struct
    struct Proposal {
        bytes32 name;
        uint voteCount;
    }
    
    // Voter struct
    struct Voter {
        uint weight;
        bool voted;
        address delegateTo;
        uint vote;
    }
    
    address public chairPerson;
    
    mapping (address => Voter) public Voters;
    
    Proposal[] public Proposals;
    
    // Constructor function
    constructor(bytes32[] proposalNames) public {
        chairPerson = msg.sender;
        Voters[chairPerson].weight = 1;
        
        for (uint i = 0; i < proposalNames.length; i++) {
            Proposals.push(Proposal({
                name: proposalNames[i],
                voteCount: 0 
            }));
        }
    }
    
    
    // giveRightToVote function
    function giveRightToVote(address voter) public {
        address sender = msg.sender;
        require(
            sender == chairPerson,
            "Only chairPerson can give right to vote"
        );
        
        require(
            !Voters[voter].voted,
            "Already voted voter does not have right to vote"
        );
        
        require(Voters[voter].weight == 0);
        Voters[voter].weight = 1;
        
    }
    
    // DelegateVote function
    
    
    
    // Vote function
    
    
    // WinningProposal function
    
    
    // WinnerName function
    
}