figure
filenames = dir('*.off');
for i=1:length(filenames)
    M = pcloud_read_off(filenames(i).name);
    clf, pcloud_view(M); movegui('east');
    pause(.1);
end