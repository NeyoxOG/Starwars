import { world, } from "@minecraft/server";
function catchupTick() {
    const overworld = world.getDimension("overworld");
    //QUERY CHECKS FOR TAGS
    let q_orgin = {
        tags: ["data_orgin"],
    };
    let q_new = {
        tags: ["data_new"],
    };
    //Banned tags and scores
    let ban_tag = ["is_host"];
    let ban_score = ["ID", "pet_id", "plane_id", "temp_id", "player_id"];
    for (let entity_orgin of overworld.getEntities(q_orgin)) {
        let myTags = entity_orgin.getTags();
        let myLocation = entity_orgin.location;
        let all_scores = world.scoreboard.getObjectives();
        for (let entity_new of overworld.getEntities(q_new)) {
            let currentTags = entity_new.getTags();
            //REMOVE TAGS
            for (let i = 0; i < currentTags.length; i++) {
                entity_new.removeTag(currentTags[i]);
            }
            //ADD TAGS
            for (let i = 0; i < myTags.length; i++) {
                if (!contains(ban_tag, myTags[i]))
                    entity_new.addTag(myTags[i]);
            }
            //ADD SCORES    
            for (let i = 0; i < all_scores.length; i++) {
                if (all_scores[i].isValid() && all_scores[i].hasParticipant(entity_orgin) && !contains(ban_score, all_scores[i].displayName)) {
                    let id = world.scoreboard.getObjective(all_scores[i].displayName).getScore(entity_orgin);
                    world.scoreboard.getObjective(all_scores[i].displayName).setScore(entity_new, id);
                }
            }
            //TELEPORT
            entity_new.teleport(myLocation);
            entity_new.removeTag("data_new");
        }
        entity_orgin.removeTag("data_orgin");
    }
}
function contains(a, obj) {
    var i = a.length;
    while (i--) {
        if (a[i] === obj) {
            return true;
        }
    }
    return false;
}
export { catchupTick };
//# sourceMappingURL=catchup.js.map
