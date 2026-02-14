import { system } from "@minecraft/server";
const offset = 1 / 16;
const buttons = [
    {
        when: [-0.1, 0.19],
        show: "archives",
    },
    {
        when: [0.28, 0.54],
        show: "temple",
    },
    {
        when: [0.65, 0.91],
        show: "crafting",
    },
    {
        when: [1.04, 1.29],
        show: "dueling",
    },
    {
        when: [1.41, 1.65],
        show: "council",
    },
];
function clear(player) {
    player.onScreenDisplay.setTitle({
        rawtext: [{ text: "hud:elevator:" }, { text: "" }],
    }, {
        fadeInDuration: 0,
        stayDuration: 0,
        fadeOutDuration: 0,
    });
}
const hoveredButtonMaps = new Map();
system.afterEvents.scriptEventReceive.subscribe((event) => {
    if (event.id === "spark:elevator_hover") {
        if (!event.sourceEntity)
            return;
        const origin = event.sourceEntity.location;
        const dim = event.sourceEntity.dimension;
        const lastHovered = hoveredButtonMaps.get(event.sourceEntity.id) || new Set();
        const nowHovered = new Set();
        hoveredButtonMaps.set(event.sourceEntity.id, nowHovered);
        for (const player of dim.getPlayers({
            location: origin,
            maxDistance: 7,
        })) {
            const entities = player.getEntitiesFromViewDirection({
                maxDistance: 5,
            });
            const box = entities.find(({ entity }) => entity.typeId === "spark:elevator_scanbox");
            if (!box) {
                clear(player);
                continue;
            }
            const hitResult = player.getBlockFromViewDirection({
                maxDistance: 5,
            });
            if (hitResult) {
                const tags = box.entity.getTags();
                const rayOrogin = player.getHeadLocation();
                const x = hitResult.block.location.x + hitResult.faceLocation.x;
                const y = hitResult.block.location.y + hitResult.faceLocation.y;
                const z = hitResult.block.location.z + hitResult.faceLocation.z;
                const differenceX = rayOrogin.x - x;
                const differenceZ = rayOrogin.z - z;
                const differenceY = rayOrogin.y - y;
                const distance = Math.sqrt(differenceX * differenceX +
                    differenceY * differenceY +
                    differenceZ * differenceZ);
                const portion = offset / distance;
                const finalY = differenceY * portion + y;
                const localY = finalY - box.entity.location.y;
                const display = buttons.find(({ when }) => {
                    const [min, max] = when;
                    return localY >= min && localY <= max;
                });
                if (display && tags.indexOf(display.show) >= 0) {
                    nowHovered.add(display.show);
                    if (player.hasTag("REMOVE_ELEVATOR_TAG"))
                        continue;
                    player.onScreenDisplay.setTitle({
                        rawtext: [
                            { text: "hud:elevator:" },
                            {
                                translate: "spark.ui.tutorial.elevator." + display.show,
                                with: ["\n"],
                            },
                        ],
                    }, {
                        fadeInDuration: 0,
                        stayDuration: 1,
                        fadeOutDuration: 0,
                    });
                }
                else {
                    clear(player);
                }
            }
            else {
                clear(player);
            }
        }
        for (const id of nowHovered) {
            if (lastHovered.has(id))
                continue;
            event.sourceEntity.runCommandAsync(`event entity @e[type=spark:elevator_button,r=4,tag=${id}] spark:hover`);
        }
        for (const id of lastHovered) {
            if (nowHovered.has(id))
                continue;
            event.sourceEntity.runCommandAsync(`event entity @e[type=spark:elevator_button,r=4,tag=${id}] spark:unpressed`);
        }
    }
});
