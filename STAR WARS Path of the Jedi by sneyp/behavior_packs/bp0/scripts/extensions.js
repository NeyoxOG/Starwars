import { Entity, Player, world } from "@minecraft/server";
export var LocationLang;
(function (LocationLang) {
    LocationLang["Dreadnaught"] = "spark.ui.location.dreadnaught";
    LocationLang["Venator"] = "spark.ui.location.venator";
    LocationLang["Puzzle"] = "puzzle.location_banner.planet_2.location1";
    LocationLang["TorrenHub"] = "puzzle.location_banner.planet_2.location2";
})(LocationLang || (LocationLang = {}));
export function init() {
    Player.prototype.clearPersistentUI = function () {
        let taskUI = world.scoreboard.getObjective("SS_ui_task");
        if (taskUI != undefined) {
            if (this.scoreboardIdentity != undefined) {
                taskUI.setScore(this.scoreboardIdentity, 0);
            }
        }
        let tutUI = world.scoreboard.getObjective("SS_ui_tutorial");
        if (tutUI != undefined) {
            if (this.scoreboardIdentity != undefined) {
                tutUI.setScore(this.scoreboardIdentity, 0);
            }
        }
        let loadingUI = world.scoreboard.getObjective("SS_ui_loading");
        if (loadingUI != undefined) {
            if (this.scoreboardIdentity != undefined) {
                loadingUI.setScore(this.scoreboardIdentity, 0);
            }
        }
    };
    /**
     * Sets up the player to be cutscene ready
     */
    Player.prototype.enableCutsceneSettings = function () {
        // set gamemode
        this.runCommandAsync("gamemode adventure @s");
        // set input
        this.runCommandAsync("inputpermission set @s camera disabled");
        this.runCommandAsync("inputpermission set @s movement disabled");
        this.addEffect("invisibility", 999, { amplifier: 1, showParticles: false });
        if (!this.hasTag("hide_ui"))
            this.addTag("hide_ui");
        // add tag
        this.addTag("cutscene");
        // clear inventory
        // get inventory
        let inventory = this.getComponent('inventory');
        inventory.container.clearAll();
    };
    /**
     * Enables input on this player
     */
    Player.prototype.enableInput = function () {
        this.runCommandAsync("inputpermission set @s camera enabled");
        this.runCommandAsync("inputpermission set @s movement enabled");
    };
    /**
     * Removes the no droid tag from the player
     */
    Player.prototype.enablePet = function () {
        if (this.hasTag("no_droid")) {
            this.removeTag("no_droid");
        }
    };
    /**
     * Sets up the player to be gameplay ready
     */
    Player.prototype.disableCutsceneSettings = function () {
        // set gamemode
        this.runCommandAsync("gamemode adventure @s");
        // set input
        this.runCommandAsync("inputpermission set @s camera enabled");
        this.runCommandAsync("inputpermission set @s movement enabled");
        this.removeEffect("invisibility");
        if (this.hasTag("hide_ui"))
            this.removeTag("hide_ui");
        // add tag
        this.removeTag("cutscene");
    };
    /**
     * Disables input on this player
     */
    Player.prototype.disableInput = function () {
        this.runCommandAsync("inputpermission set @s camera disabled");
        this.runCommandAsync("inputpermission set @s movement disabled");
    };
    /**
     * Disables the playes pet.
     */
    Player.prototype.disablePet = function () {
        if (!this.hasTag("no_droid")) {
            this.addTag("no_droid");
        }
    };
    /*
    * This only supports a fade of 1
    */
    Player.prototype.fadeIn = function (sound = 'sound.spark.transitioner_fade_general') {
        this.onScreenDisplay.setActionBar("hud:fade_in_1");
        this.playSound(sound, { pitch: 1, volume: 1 });
    };
    /*
    * This only supports a fade of 1
    */
    Player.prototype.fadeOut = function (sound = 'sound.spark.transitioner_fade_general') {
        this.onScreenDisplay.setActionBar("hud:fade_out_1");
        this.playSound(sound, { pitch: 1, volume: 1 });
    };
    /*
    * This only supports a fade of 0.3
    */
    Player.prototype.fadeOutFast = function (sound = 'sound.spark.transitioner_fade_general') {
        this.onScreenDisplay.setActionBar("hud:fade_out_0_3");
        this.playSound(sound, { pitch: 1, volume: 1 });
    };
    Player.prototype.setDefaultHotbarLoadout = function () {
        // doing all of this by commands again...
        this.runCommandAsync("function spark/lightsaber/give_lightsaber");
        this.runCommandAsync("replaceitem entity @s slot.hotbar 1 spark:push 1 0 {\"minecraft:item_lock\":{ \"mode\": \"lock_in_slot\" }, \"minecraft:keep_on_death\":{}}");
        this.runCommandAsync("replaceitem entity @s slot.hotbar 2 spark:grab 1 0 {\"minecraft:item_lock\":{ \"mode\": \"lock_in_slot\" }, \"minecraft:keep_on_death\":{}}");
        this.runCommandAsync("replaceitem entity @s slot.hotbar 3 spark:pull 1 0 {\"minecraft:item_lock\":{ \"mode\": \"lock_in_slot\" }, \"minecraft:keep_on_death\":{}}");
    };
    // setEscapePrisonHotbarLoading
    Player.prototype.setEscapePrisonHotbarLoading = function () {
        this.runCommandAsync("replaceitem entity @s slot.hotbar 1 spark:push 1 0 {\"minecraft:item_lock\":{ \"mode\": \"lock_in_slot\" }, \"minecraft:keep_on_death\":{}}");
        this.runCommandAsync("replaceitem entity @s slot.hotbar 2 spark:grab 1 0 {\"minecraft:item_lock\":{ \"mode\": \"lock_in_slot\" }, \"minecraft:keep_on_death\":{}}");
        this.runCommandAsync("replaceitem entity @s slot.hotbar 3 spark:pull 1 0 {\"minecraft:item_lock\":{ \"mode\": \"lock_in_slot\" }, \"minecraft:keep_on_death\":{}}");
    };
    Player.prototype.sendUiNotification = function () {
        this.playSound("sound.spark.ui_notification");
    };
    Player.prototype.setTutorialMessage = function (number, sound) {
        // get scoreboard
        world.scoreboard.getObjective("SS_ui_tutorial")?.setScore(this, number);
        if (sound != undefined) {
            this.playSound(sound);
        }
    };
    Player.prototype.setTask = function (number, sound) {
        // get scoreboard
        world.scoreboard.getObjective("SS_ui_task")?.setScore(this, number);
        if (sound != undefined) {
            this.playSound(sound);
        }
    };
    Player.prototype.sendAnnouncement = function (langKey, sound = "sound.spark.success_major") {
        let raw = {
            rawtext: [
                {
                    text: "hud:announce:"
                },
                {
                    translate: langKey
                }
            ]
        };
        this.onScreenDisplay.setActionBar(raw);
        this.playSound(sound);
    };
    Player.prototype.displayLocation = function (loc, sound) {
        let raw = {
            rawtext: [
                {
                    text: "hud:location:"
                },
                {
                    translate: loc
                }
            ]
        };
        this.onScreenDisplay.setActionBar(raw);
        if (sound != undefined) {
            this.playSound(sound);
        }
    };
    Entity.prototype.despawn = function () {
        this.triggerEvent("spark:despawn");
    };
}
