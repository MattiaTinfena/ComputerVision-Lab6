function show_matches(img1, img2, lst, inverted, figidx)
% USAGE: show_matches(img1, img2, lst, inverted)
% visualizes the two images and the list of matched features
%   img1 img2   stereo pair of images
%   lst         list of correspondences computed over the stereo pair
%   inverted    boolean flag to be set to 1 if the correspondences have been computed using SIFT descriptors
%

display(['Features matched: ' num2str(size(lst,1))]);

N = size(img1, 2);

Nrows = max(size(img1,1), size(img2,1));
Ncols = size(img1,2) + size(img2,2);
 
img = uint8(zeros(Nrows, Ncols));
img(1:size(img1,1), 1:size(img1,2)) = img1;
img(1:size(img2,1), size(img1,2)+1:size(img1,2)+size(img2,2)) = img2;

figure(figidx);
imshow(img);
hold on;
    for i=1:size(lst,1)
        coords = lst(i,:);
        if(inverted)    % SIFT mode
            plot(coords(1), coords(2), 'Marker', 'o', 'Color', 'blue', 'MarkerSize', 9);
            text(coords(1), coords(2), [int2str(i) '   '], 'Color', 'yellow', 'HorizontalAlignment', 'right', 'FontSize', 9);
            plot(N+coords(3), coords(4), 'Marker', 'o', 'Color', 'blue', 'MarkerSize', 9);
            text(N+coords(3), coords(4), ['   ' int2str(i)], 'Color', 'yellow', 'HorizontalAlignment', 'left', 'FontSize', 9);
            plot([coords(1), (N+coords(3))], [coords(2), coords(4)], 'b', 'LineWidth', 1);
        else
            plot(coords(2), coords(1), 'Marker', 'o', 'Color', 'blue', 'MarkerSize', 9);
            text(coords(2), coords(1), [int2str(i) '   '], 'Color', 'yellow', 'HorizontalAlignment', 'right', 'FontSize', 9);
            plot(N+coords(4), coords(3), 'Marker', 'o', 'Color', 'blue', 'MarkerSize', 9);
            text(N+coords(4), coords(3), ['   ' int2str(i)], 'Color', 'yellow', 'HorizontalAlignment', 'left', 'FontSize', 9);
            plot([coords(2), (N+coords(4))], [coords(1), coords(3)], 'b', 'LineWidth', 1);
        end
    end

end