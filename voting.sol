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
    
    mapping (address => Voter) public voters;
    
    Proposal[] public proposals;
    
    // Constructor function
    constructor(bytes32[] proposalNames) public {
        chairPerson = msg.sender;
        voters[chairPerson].weight = 1;
        
        for (uint i = 0; i < proposalNames.length; i++) {
            proposals.push(Proposal({
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
            !voters[voter].voted,
            "Already voted voter does not have right to vote"
        );
        
        require(voters[voter].weight == 0);
        voters[voter].weight = 1;
        
    }
    
    // DelegateVote function
    function delegateVote(address to) public {
        Voter storage sender = voters[msg.sender];
        require(!sender.voted, "You have already voted");
        require(to != msg.sender, "You cannot delegate right to yourself");
        
        while(voters[to].delegateTo != address(0)) {
            to = voters[to].delegateTo;
        }
        
        Voter storage delegate_ = voters[to];
        sender.voted = true;
        sender.delegateTo = to;
        if (delegate_.voted) {
            proposals[delegate_.vote].voteCount++;
        } else {
            delegate_.weight++;
        }
    }
    
    
    
    // Vote function
    function vote(uint proposal) public {
        Voter storage sender = voters[msg.sender];
        require(!sender.voted, "You have already voted");
        sender.voted = true;
        sender.vote = proposal;
        proposals[sender.vote].voteCount++;
    }
    
    
    // WinningProposal function
    function winningProposal() public view returns (uint winningProposalCode) {
        uint winningProposalCount = 0;
        for (uint p = 0; p < proposals.length; p++) {
            if (proposals[p].voteCount > winningProposalCount) {
                winningProposalCount = proposals[p].voteCount;
                winningProposalCode = p;
            }
        }
    }
    
    
    // WinnerName function
    function winnerName() public view returns (bytes32 winningProposalName) {
        winningProposalName = proposals[winningProposal()].name;
    }
    
}