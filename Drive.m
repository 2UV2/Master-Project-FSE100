
Main(brick);

% Main Function

function Main(Robot)
FinishLine = false;
PickUpPerson = false;
Nav = [];

Robot.ResetMotorAngle('A');
Robot.ResetMotorAngle('B');
MoveForward(Robot);

while true
    HitWall(Robot);
    if OverColoredLine(Robot)
        Robot.StopAllMotors('Brake')
        break;
    end
end

end

% Reactive Functions

function HitWall(Robot)
    if Robot.TouchPressed(1) || Robot.TouchPressed(2)
        MoveBackward(Robot);
        pause(3);
        Robot.StopAllMotors('Brake');
        pause(1);
        if CheckWallOnRight(Robot) == 1
            TurnLeft(Robot);
            disp(Robot.UltrasonicDist(4));
        elseif CheckWallOnRight(Robot) == 0
            TurnRight(Robot);
            disp(Robot.UltrasonicDist(4));
        end
        disp(CheckWallOnRight(Robot));
        pause(6);
        MoveForward(Robot);
    end
end

function TheFinishLine = OverColoredLine(Robot)
    if Robot.ColorCode(3) == 4
        pause(2);
        Robot.StopAllMotors('Brake');
        pause(1);
        TurnAround(Robot);
        pause(3);
        PickUpClaw(Robot);
        pause(3);
        MoveForward(Robot);
        pause(3);
    elseif Robot.ColorCode(3) == 3
        pause(2);
        TheFinishLine = true;
        return
    end

    TheFinishLine = false;
    return
end

function Check = CheckWallOnRight(Robot)
    if Robot.UltrasonicDist(4) < 40
        Check = true;
        return
    end
    if Robot.UltrasonicDist(4) > 40
        Check = false;
        return
    end
    disp(Robot.UltrasonicDist(4));
end

function PickUpClaw(Robot)
    Robot.MoveMotor('C',-100);
    pause(5);
    Robot.StopMotor('C','Brake');
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
    pause(6);
end
