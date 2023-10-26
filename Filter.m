for x = 1 : 100
    if mod(x , 3) ~= 0 && mod(x , 7) ~= 0
        disp(x);
    end
        if mod(x , 21) == 0
            disp(x);
        end
end
