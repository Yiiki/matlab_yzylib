function axout = molecule3D_v2(varargin)
%MOLECULE3D Draw 3D molecules
%   MOLECULE3D(XYZ,LAB) draws the molecule defined by the position matrix
%   XYZ based on the labels in the cell array LAB. XYZ is a matrix with
%   three columns representing the cartesian coordinates x, y and z in
%   舗gstr鰉 with one line per atom. LAB is used to adapt the color and
%   geometry of each atom. Bonds are added if the distance between two
%   atoms is closer than 1.6 �.
%
%   MOLECULE3D(XYZ,LAB,STYLE) allows to change the appearance of the
%   molecule. STYLE can be on of the strings 'ballstick', 'licorice',
%   'large', or 'superlarge'. Just try it out!
%
%   MOLECULE3D(AX,...) plots into AX as the main axes, instead of GCA.
%
%   AX = MOLECULE3D(...) returns the handle of the axis.
%
%   Check out the examples in example_molecule3D.m!
%
%   Version: 1.2
%   Author:  Andr� Ludwig (aludwig@phys.ethz.ch)

% geometry settings
RC = 0.1; % radius of bonds
DBOND = 2.5; % maximal distance of atoms forming bond

% resolution of spheres and cylinders
NS = 50; % spheres, more looks smoother
NB = 50; % more looks smoother

% check input arguments
narginchk(2,inf);

if numel(varargin{1}) == 1 && ishghandle(varargin{1}(1)) && ...
        isequal(lower(char(get(varargin{1}(1),'type'))),'axes')
    ax = varargin{1};
    offs = 1;
else
    ax = [];
    offs = 0;
end

xyz = varargin{1+offs};
Na = size(xyz,1); % number of atoms in molecule

lab = varargin{2+offs};
if ~iscellstr(lab)
    error('Input LAB has to be a cell string')
end
lab = lab(:); % convert to column vector
if nargin - offs > 2
    bond_menu=varargin{3+offs};
    fprintf('Custum bond setting used.\n')
else
    bond_menu={'YYY1','YYY2',num2str(DBOND);
        };
    fprintf('Default bond setting used.\n')
end

if nargin - offs < 4
    style = 'ballstick'; % set default style to rad/stick
else
    style = varargin{4+offs};
end

if ~any(strcmp(style,{'ballstick','licorice','large','superlarge'}))
    warning('Style "%s" not found.',style)
    style = 'ballstick'; % fallback
end

if size(xyz,2) ~= 3 || Na < 1
    error('First argument should be N times 3 matrix.')
end

if numel(lab) ~= Na
    error('Number of labels does not match number of columns.')
end

% prepare axis
ax = newplot(ax);
axes(ax);
set(ax,'Visible','on','DataAspectRatio',[1 1 1]) % fix aspect ratio
set(ax,'Color','none')
light('Position',[1 1 2]); % add some light

% all combinations of atom pairs
% pairs = combnk(1:Na,2);
pairs = nchoosek(1:Na,2);
% all interatomic distances
ds = sqrt(sum((xyz(pairs(:,1),:) - xyz(pairs(:,2),:)).^2,2)); 

% find bonds based on distances of atoms -------------------------ABORTED
% ABORTED % ks = find( ...
% ABORTED %           ds < DBOND ...                                                 % only bond
% ABORTED %     & ~( strcmp(lab(pairs(:,1)),'H') & strcmp(lab(pairs(:,2)),'H') ) ... % no H-H bond
% ABORTED %     & ~( strcmp(lab(pairs(:,1)),'O') & strcmp(lab(pairs(:,2)),'O') ) ... % no O-O bond
% ABORTED %                                                                    )';

% new find ks vector method by YZY
% the old version only has one kind of bond

% first, do a idx_global ---> ibond_type mapping
% input
% ------
% bond_menu : a cell matrix
% such as
% >> bond_menu={
% >> 'O','H','1.2';
% >> 'O','C','1.2';
% >> };
fprintf('start to sparse the bond ...\n')

bndlis=zeros(size(ds,1),1);
for iib=1:size(ds,1)
    % fprintf('iib=%d th dist, ds(iib)=%.6f\n',iib,ds(iib))
    for itype=1:size(bond_menu,1)
        atom1=bond_menu(itype,1);
        atom2=bond_menu(itype,2);
        ilogi= ...
         (strcmp(lab(pairs(iib,1)),atom1) & strcmp(lab(pairs(iib,2)),atom2)) ...
        |(strcmp(lab(pairs(iib,1)),atom2) & strcmp(lab(pairs(iib,2)),atom1)) ...
        |(           strcmp(atom1,'YYY1') & strcmp(atom2,'YYY2')           );
        % fprintf('itype=%d th bond, bond(itype)=%.6f\n',itype,str2double(bond_menu(itype,3)))
        if(ilogi)
        bndlis(iib)=str2double(bond_menu(itype,3));
        continue
        end
    end
end

ks = find(ds < bndlis)';
fprintf('finish sparsing bond, total bond %d\n',length(ks));
% draw sphere with adapted radius for each element / line in xyz
for k = 1:size(xyz,1)
    thiscol = col(lab{k});
    
    switch style
        case 'ballstick'
            thisr = rad(lab{k});
        case 'licorice'
            thisr = RC;
        case 'large'
            thisr = 2*rad(lab{k});
        case 'superlarge'
            thisr = 3*rad(lab{k});
    end
    
    % basic sphere
    [sx,sy,sz] = sphere(NS);
    
    % draw sphere
    surface('XData',xyz(k,1) + thisr*sx,'YData',xyz(k,2) + thisr*sy, ...
        'ZData',xyz(k,3) + thisr*sz,'FaceColor',thiscol, ...
        'EdgeColor','none','FaceLighting','gouraud')
end

% draw cylinders for each bond
for k = ks % draw sticks for all bounds
    r1 = xyz(pairs(k,1),:); % coordinates atom 1
    r2 = xyz(pairs(k,2),:); % coordinates atom 2
    
    % bond angles in spherical coordinates
    v = (r2-r1)/norm(r2-r1);
    phi = atan2d(v(2),v(1));
    theta = -asind(v(3));
    
    % bond distance minus sphere radii
    bd = ds(k) - rad(lab{pairs(k,1)}) - rad(lab{pairs(k,2)});
    cyl2 = rad(lab{pairs(k,1)}) + bd/2; % length half bond cylinder
    cyl1 = ds(k); % length full bond cylinder
    
    % prototype cylinders for bond
    [z,y,x] = cylinder(RC,NB); % full bond cylinder
    x(2,:) = x(2,:) * cyl1; % adjust length
    [z2,y2,x2] = cylinder(RC*1.01,NB); % half bond cylinder, thicker
    x2(2,:) = x2(2,:) * cyl2; % adjust length
    
    % rotate cylinders to match bond vector v
    for kk = 1:numel(x)
        vr = [x(kk); y(kk); z(kk);];
        vr = rotz(phi)*roty(theta)*vr;
        x(kk) = vr(1);
        y(kk) = vr(2);
        z(kk) = vr(3);
        
        vr = [x2(kk); y2(kk); z2(kk);];
        vr = rotz(phi)*roty(theta)*vr;
        x2(kk) = vr(1);
        y2(kk) = vr(2);
        z2(kk) = vr(3);
    end
    
    % get colors of both atoms
    thiscol1 = col(lab{pairs(k,2)});
    thiscol2 = col(lab{pairs(k,1)});
    
    % full bond color 1
    surface('XData',r1(1) + x,'YData',r1(2) + y,...
        'ZData',r1(3) + z,'FaceColor',thiscol1,...
        'EdgeColor','none','FaceLighting','gouraud')
    
    % half bond color 2
    surface('XData',r1(1) + x2,'YData',r1(2) + y2,...
        'ZData',r1(3) + z2,'FaceColor',thiscol2,...
        'EdgeColor','none','FaceLighting','gouraud')
end

if nargout > 0
    axout = ax;
end

%---------------------------------------------
% element specific CPK colors
function c = col(s)
switch s
    case  'H', c = [1 1 1];
    case  'C', c = [0.2 0.2 0.2];
    case  'O', c = [1.0 0.1 0.1];
    case   'Si', c=[56, 83, 241]./256;%     case  'Si', c = [0.5 0.5 0.6];
    case  'I', c = [0.4 0.1 0.7];
    case  {'F','Cl'}, c = [0.2 0.9 0.2];
    case  'Br', c = [0.6 0.1 0.1];
    case  {'He','Ne','Ar','Kr','Xe'}, c = [0.2 1.0 1.0];
    case  'P', c = [1.0 0.6 0.2];
    case  'S', c = [0.9 0.9 0.2];
    case  'B', c = [1.0 0.7 0.5];
    case  {'Li','Na','K','Rb','Cs','Fr'}, c = [0.5 0.1 1.0];
    case  {'Be','Mg','Ca','Sr','Ba','Ra'}, c = [0.1 0.5 0.1];
    case  'Ti', c = [0.6 0.6 0.6];
    case  'Fe', c = [0.9 0.5 0.1];
    case   'Au', c= [212,175,55]./256;
    case   'Ga', c= [ 0,128,255]./256;
    case   'As', c= [116,208,87]./256;
    otherwise, c = [0.9 0.5 1.0];
end

%---------------------------------------------
% element specific radii
function r = rad(s)
switch s
    case  'H', r = 0.3;
    case  'C', r = 0.5;
    case  'O', r = 0.5/2.5;
    case  'Si', r = 1.11/3.5;
    case  'I', r = 1.15/2;
    case  'Au', r=1.74/2;
    case  'Ga', r = 1.30/2;
    case  'As', r=1.15/2;
    otherwise, r = 0.5;
end