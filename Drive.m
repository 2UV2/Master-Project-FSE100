brick.ResetMotorAngle('A');
brick.ResetMotorAngle('B');

MoveForward(brick);

while true
    HitWall(brick);
    OverColoredLine(brick);
end

% Reactive Functions

function HitWall(Robot)
    if Robot.TouchPressed(1) || Robot.TouchPressed(2)
        MoveBackward(Robot);
        pause(3);
        Robot.StopAllMotors('Brake');
        pause(1);
        if CheckWallOnRight(Robot) 
            TurnLeft(Robot);
        else
            TurnRight(Robot);
        end
        pause(6);
        MoveForward(Robot);
    end
end

function OverColoredLine(Robot)
    if Robot.ColorCode(3) == 4
        pause(2);
        Robot.StopAllMotors('Brake');
        pause(1);
        TurnAround(Robot);
        pause(1);
        MoveForward(Robot);
    end
end

function Check = CheckWallOnRight(Robot)
    if Robot.UltrasonicDist(4) < 20
        Check = true;
        return
    else 
        Check = false;
        return
    end
end

function PickUpClaw(Robot)
    Robot.MoveMotor('C',-100);
end
% Turn Functions

function MoveForward(Robot)
    Robot.MoveMotor('AB',-80);
end


function MoveBackward(Robot)
    Robot.MoveMotor('AB',100);
end 


function TurnRight(Robot)
    Robot.ResetMotorAngle('A');
    Robot.MoveMotorAngleRel('A',100,1940, 'Brake');
end


function TurnLeft(Robot)
    Robot.ResetMotorAngle('B');
    Robot.MoveMotorAngleRel('B',100,1940, 'Brake');
end

function TurnAround(Robot)
    Robot.ResetMotorAngle('A');
    Robot.MoveMotorAngleRel('A',100,1940, 'Brake');
    pause(6);
    Robot.ResetMotorAngle('A');
    Robot.MoveMotorAngleRel('A',100,1940, 'Brake');
end
