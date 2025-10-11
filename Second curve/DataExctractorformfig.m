% One-shot script to extract black curve (shorter) and fit curve (longer) from .fig
% Save this as extract_curves.m and run in MATLAB

% === Step 1: Open .fig and get axes ===
fig = openfig('RFRself.fig','invisibl        e');   % replace with your fig name
ax  = get(fig, 'CurrentAxes');               % get axis handle

% === Step 2: Find all line objects ===
lines = findall(ax, 'Type', 'line');

% === Step 3: Extract data ===
curveData = cell(numel(lines),1);
curveLength = zeros(numel(lines),1);

for i = 1:numel(lines)
    x = get(lines(i), 'XData');
    y = get(lines(i), 'YData');
    curveData{i} = [x(:), y(:)];
    curveLength(i) = numel(x);
end

% === Step 4: Identify shorter (black curve) and longer (fit curve) ===
[~, idxShort] = min(curveLength);   % shorter curve
[~, idxLong]  = max(curveLength);   % longer curve

blackCurve = curveData{idxShort};
fitCurve   = curveData{idxLong};

% === Step 5: Save both to CSV ===
writematrix(blackCurve, 'black_curve.csv');   % shorter one
writematrix(fitCurve, 'fit_curve.csv');       % longer one

disp('✅ Black curve saved as black_curve.csv');
disp('✅ Fit curve saved as fit_curve.csv');

close(fig); % cleanup
