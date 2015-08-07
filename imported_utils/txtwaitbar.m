% PROGRESS short description
%
% SYNTAX
% h = txtwaitbar('init', 'my title');   % creates a progressbar with given title
% h = txtwaitbar(rate, h);              % updates the bar to rate (%) "rate"
% txtwaitbar('close',h)                 % closes the bar (optional)
%
% INPUT PARAMETERS
%   rate:   the percentage of completion
%   title:  the title to be given to the textbar
%   h:      the handler of the progressbars
%
% OUTPUT PARAMETERS
%   h: a structure that contain internal information of the progressbar
% 
% TEMPLATE:
% htxt = txtwaitbar('init', '');
% htxt = txtwaitbar(rate, htxt);
% txtwaitbar('close',htxt)     
% 
% See also:
% TXTWAITBAR_DEMO
%
% References:
% [1] progress.m, mathworks file id: 16213 (http://www.mathworks.com/matlabcentral/
%     fileexchange/loadFile.do?objectId=16213&objectType=file)

% Copyright (c) 2008 Andrea Tagliasacchi
% All Rights Reserved
% email: ata2@cs.sfu.ca 
% $Revision: 1.0$  Created on: 2008/09/25
% 
% Adapted from:
% By Joseph martinot-Lagarde
% joseph.martinot-lagarde@m4x.org
function h = txtwaitbar( varargin )

% skipe the waitbars completely (debug output)
if ~isempty(whos('global','SKIP_WAITBAR'))
    h = [];
    return;
end

%%% local parameters
TXTBAR_MAXLENGTH = 50;     % width of the textual progress bar
rate             = 0;      % default % of completion

if nargin ~= 2
    error('print synopsis');
end

% check if we are just closing
if ischar( varargin{1} )
    h = struct();

    % check the status
    if strcmp(varargin{1}, 'close')
        h = varargin{2};
        close();
    elseif strcmp(varargin{1}, 'init')
        h.title = varargin{2};
        init();
    end

% this is an update request
elseif isnumeric( varargin{1} ) 
    rate = varargin{1};
    h = varargin{2};
    update();
else
    error('show SYNOPSIS');
end

function init()
    h.n_title = length( h.title );
    h.n_bar = TXTBAR_MAXLENGTH;
    h.act_length = 0;
    h.pad_length = h.n_bar - h.act_length;
    barchars = sprintf('[%s%s]\n', strrep('*',h.act_length), strrep(' ',h.pad_length));
    fprintf( [h.title, barchars] );
end
function close()
	pause(0.01); % built in workaround as mentioned by [1]
    fprintf(strrep('\b',TXTBAR_MAXLENGTH+4+h.n_title-1)); %-1 bug
end
function update()
    % nothing changed.. return
    act_length_prev = h.act_length;
    h.act_length = ceil(rate*h.n_bar);
    h.pad_length = h.n_bar - h.act_length;
    if act_length_prev == h.act_length
        return
    end
    
    %%% Delete the bar completely
    delchars = sprintf('%s', strrep('\b',TXTBAR_MAXLENGTH+3));
    barchars = sprintf('[%s%s]\n', strrep('*',h.act_length), strrep(' ',h.pad_length));
    fprintf( [delchars, barchars] );

    %%% partially update instead of redraw
    % delta = h.act_length-act_length_prev;
    % disp(delta);
    % delchars = sprintf('%s', strrep('\b',TXTBAR_MAXLENGTH) );
    % barchars = sprintf('[%s%s]\n', strrep('*',h.act_length), strrep(' ',h.pad_length));
    % fprintf( [delchars, barchars] );
end
function string = strrep( character, N )
    K = length(character);
    string = blanks( K*N );
    for k=1:K
        string(k:K:end) = character( k*ones(1,N) );
    end
end

end % ----------- END OF FUNCTION ------------ %
