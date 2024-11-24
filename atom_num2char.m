function chr=atom_num2char(at)
switch at
    case 1
        chr='H';
    case 8
        chr='O';
    case 14
        chr='Si';
    case 79
        chr='Au';
    case 31
        chr='Ga';
    case 33
        chr='As';
    case 97
        chr='Bk';
    otherwise
        fprintf('at=%d\n',at)
        error('Not expect.')
end
end