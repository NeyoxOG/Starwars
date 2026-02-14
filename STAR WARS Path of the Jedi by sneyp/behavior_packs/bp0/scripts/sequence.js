// basic class holding a manger that can take in things to do on a given step
export class SequenceManger {
    constructor(scoreboard) {
        this.steps = [];
        this.tick = 0;
        this.endTime = 0;
        this.enabled = false;
        this.finished = false;
        this.scoreboard = scoreboard;
        this.activeState = 0;
    }
    clear() {
        this.steps = [];
        this.tick = 0;
        this.endTime = 0;
        this.enabled = false;
        this.finished = false;
    }
    createStepOnTick(tick, action, id) {
        let s = new SequenceStep();
        s.triggerTick = tick;
        s.action = action;
        this.steps.push(s);
        // set max
        if (tick > this.endTime)
            this.endTime = tick;
        if (id != undefined) {
            s.stepID = id;
        }
        return s;
    }
    createStepBetweenRange(min, max, action, id) {
        let s = new SequenceStep();
        s.triggerRangeMin = min;
        s.triggerRangeMax = max;
        s.action = action;
        this.steps.push(s);
        // set max
        if (max > this.endTime)
            this.endTime = max;
        if (id != undefined) {
            s.stepID = id;
        }
        return s;
    }
    createAlwaysActiveStep(action, id) {
        let s = new SequenceStep();
        s.alwaysRun = true;
        s.action = action;
        this.steps.push(s);
        this.endTime = Number.MAX_SAFE_INTEGER;
        if (id != undefined) {
            s.stepID = id;
        }
        return s;
    }
    isActive() {
        return this.enabled;
    }
    start(atStep = 0) {
        if (atStep <= this.steps.length) {
            // loop over the steps until we get a step id, then go with that
            for (const step of this.steps) {
                if (step.stepID != undefined) {
                    if (step.stepID == atStep) {
                        if (step.triggerTick != undefined) {
                            this.tick = step.triggerTick - 1;
                        }
                        if (step.triggerRangeMin != undefined && step.triggerRangeMax != undefined) {
                            this.tick = step.triggerRangeMin - 1;
                        }
                    }
                }
            }
        }
        this.enabled = true;
    }
    stop() {
        this.enabled = false;
    }
    update() {
        if (this.enabled) {
            for (let i = 0; i < this.steps.length; i++) {
                let step = this.steps[i];
                if (step.update(this.tick)) {
                    this.activeState = step.stepID == undefined ? 0 : step.stepID;
                }
            }
            if (this.tick > this.endTime) {
                this.enabled = false;
                return;
            }
            // increment step
            this.tick++;
        }
    }
}
export class SequenceStep {
    constructor() {
        this.action = () => { };
        this.triggerTick = undefined;
        this.triggerRangeMin = undefined;
        this.triggerRangeMax = undefined;
        this.alwaysRun = false;
        this.stepID = undefined;
    }
    update(tick) {
        if (this.alwaysRun) {
            this.action(tick);
            return false;
        }
        if (this.triggerTick != undefined) {
            if (tick == this.triggerTick) {
                this.action(tick);
                return true;
            }
        }
        if (this.triggerRangeMin != undefined && this.triggerRangeMax != undefined) {
            if (tick >= this.triggerRangeMin && tick <= this.triggerRangeMax) {
                this.action(tick);
                return true;
            }
        }
        return false;
    }
}
