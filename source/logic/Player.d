module nomads.logic.Player;

import nomads;

/**
 * The possible states a player can be in while in game
 */
enum PlayerState {
    NOMAD=0,
    KINGDOM=1,
    EMPIRE=2
}

/** 
 * A class representing an in-game player
 * Stores the player's attributes, among other things
 */ 
class Player {

    Color color; ///The color that represents this player
    string name; ///The player's name
    int victoryPoints; ///The number of victory points this player has
    PlayerState state; ///The state this player is in
    Town[] controlled; ///The towns under this player's control

    int gold; ///The amount of gold this player has
    int[] culture; ///A list of all of the culture values the player has in each era
    int totalCulture; ///The total culture this player has accumulated

    /**
     * Constructs a new player
     */
    this(Color color, string name, PlayerState state=PlayerState.NOMAD) {
        this.color = color;
        this.name = name;
        this.state = state;
    }

}