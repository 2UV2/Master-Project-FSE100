MoveForward(brick);

while true

    HitWall(brick);

    pause(1);
end

function HitWall(Robot)
    if Robot.TouchPressed(1)
        MoveBackward(Robot);
    end
end

function MoveForward(Robot)
    Robot.MoveMotor('AB',-50);
end


function MoveBackward(Robot)
    Robot.MoveMotor('AB',50);
end


function TurnRight(Robot)
    
end


function TurnLeft(Robot)
    
end

function TurnAround(Robot)
    
end
