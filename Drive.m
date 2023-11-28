Main(brick);

% Main Function

function Main(Robot)
Deboun = 0;
FinishLine = false;
PickUpPerson = false;
Nav = [];

Robot.ResetMotorAngle('A');
Robot.ResetMotorAngle('B');
MoveForward(Robot);

    while true
        HitWall(Robot);
        if Robot.UltrasonicDist(4) > 40
            if Deboun == 0 
                FollowRightWall(Robot,true);
                Deboun = 1;
            else
                FollowRightWall(Robot,false);
            end
        end
        if OverPickUpLine(Robot,PickUpPerson)
            PickUpPerson = true;

            if OverFinishLine(Robot)
                Robot.StopAllMotors('Brake')
                break;
            end
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

function FollowRightWall(Robot,FristTime)
    if FristTime == true
        Robot.StopAllMotors('Brake');
        pause(1);
        TurnRight(Robot);
        pause(6);
        MoveForward(Robot);
        pause(7);
    else
        pause(6);
        Robot.StopAllMotors('Brake');
        pause(1);
        TurnRight(Robot);
        pause(6);
        MoveForward(Robot);
        pause(7);
    end
end

function ThePickUp = OverPickUpLine(Robot,deboun)
if deboun == false
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
        ThePickUp = true;
        return
    end
elseif deboun == true
    ThePickUp = true;
    return
end

    ThePickUp = false;
    return
end

function TheFinishLine = OverFinishLine(Robot)
    if Robot.ColorCode(3) == 3
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
