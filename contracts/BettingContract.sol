// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BettingContract {
    address public owner;
    uint256 public deadline;
    uint256 public minimumBet;
    Team public winningTeam;

    enum Team {TeamA, TeamB}

    struct Bet {
        address player;
        Team team;
        uint256 amount;
        bool claimed;
    }

    mapping(address => Bet) public bets;
    Bet[] public betList;

    event BetPlaced(address indexed player, Team indexed team, uint256 amount);
    event WinnerAnnounced(Team indexed team);
    event PrizeClaimed(address indexed player, uint256 amount);

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function");
        _;
    }

    modifier onlyBeforeDeadline() {
        require(block.timestamp < deadline, "Betting is closed");
        _;
    }

    modifier onlyAfterDeadline() {
        require(block.timestamp >= deadline, "Betting is still open");
        _;
    }

    constructor(uint256 _durationInMinutes, uint256 _minimumBet) {
        owner = msg.sender;
        deadline = block.timestamp + _durationInMinutes * 1 minutes;
        minimumBet = _minimumBet;
    }

    function placeBet(Team _team) external payable onlyBeforeDeadline {
        require(msg.value >= minimumBet, "Bet amount is below the minimum");
        require(bets[msg.sender].amount == 0, "You can only place one bet");

        Bet memory newBet = Bet({
            player: msg.sender,
            team: _team,
            amount: msg.value,
            claimed: false
        });

        bets[msg.sender] = newBet;
        betList.push(newBet);

        emit BetPlaced(msg.sender, _team, msg.value);
    }

    function announceWinner(Team _winningTeam) external onlyOwner onlyAfterDeadline {
        winningTeam = _winningTeam;
        emit WinnerAnnounced(_winningTeam);
    }

    function claimPrize() external onlyAfterDeadline {
        require(bets[msg.sender].team == winningTeam, "You did not bet on the winning team");
        require(!bets[msg.sender].claimed, "Prize already claimed");

        uint256 prizeAmount = calculatePrizeAmount(msg.sender);
        require(prizeAmount > 0, "No prize to claim");

        bets[msg.sender].claimed = true;
        payable(msg.sender).transfer(prizeAmount);

        emit PrizeClaimed(msg.sender, prizeAmount);
    }

    function calculatePrizeAmount(address _player) internal view returns (uint256) {
        Bet storage playerBet = bets[_player];

        if (playerBet.team == winningTeam) {
            uint256 totalWinningAmount = 0;

            for (uint256 i = 0; i < betList.length; i++) {
                if (betList[i].team == winningTeam) {
                    totalWinningAmount += betList[i].amount;
                }
            }

            return (playerBet.amount * address(this).balance) / totalWinningAmount;
        } else {
            return 0;
        }
    }

    receive() external payable {
        // Allow the contract to receive funds
    }
}

