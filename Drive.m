brick.ResetMotorAngle('A');
brick.ResetMotorAngle('B');
MoveForward(brick);

while true

    HitWall(brick);
   

    pause(0.2);
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


% Turn Functions

function MoveForward(Robot)
    Robot.MoveMotor('AB',-50);
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
    
end

function Check = CheckWallOnRight(Robot)
    if Robot.UltrasonicDist(4) < 15
        Check = true;
        return
    else 
        Check = false;
        return
    end
end
