function order = prioritiseOrder(order)

i=2;
firstNon = 2;
while i <= order{1}
    if order{i}(6) == 1
        temp = order(i);
        order(i) = order(firstNon);
        order(firstNon) = temp;
        firstNon = firstNon + 1;
    end
    i = i+1;
    
end
end
