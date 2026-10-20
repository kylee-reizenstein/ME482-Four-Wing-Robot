
% ME 482 Extra Credit
% Kylee Reizenstein
% Cheng et al. (2020), Figure 6
% Approximate data from the published graph

clear; clc; close all

freq = [10.3 13.0 15.0 17.0 18.5 19.5 21.8 25.0];
deltaL = [0.20 0.06 0.10 0.00 0.55 0.76 1.71 3.20];

% Fit model using 18 Hz as the starting point

f0 = 18;
x=max(freq-f0,0);

k = sum(x.*deltaL)/sum(x.^2);

modelAtData = k*x;

SSres = sum((deltaL-modelAtData).^2);
SStot=sum((deltaL-mean(deltaL)).^2);

R2 = 1-SSres/SStot;

% Graph the original points and fitted model

fplot = linspace(10,25,300);
modelCurve=k*max(fplot-f0,0);

figure('Color','w')

plot(freq,deltaL,'o','MarkerSize',7,'LineWidth',1.4)
hold on
plot(fplot,modelCurve,'-','LineWidth',1.6)

xline(f0,'--','18 Hz threshold','LabelVerticalAlignment','bottom');

xlabel('Flapping frequency, f (Hz)')
ylabel('Lift difference (g-equivalent)')
title('Clap-and-fling Lift Increase')
legend('Approximate Figure 6 Data','Fitted Model','Location','northwest')

grid on
xlim([10 25.8]);
ylim([-0.1 3.7]);

% Display results

fprintf('Fitted slope k = %.4f g-equivalent/Hz\n',k);
fprintf('R-squared = %.4f\n',R2);

for f = [20 22 25]

    gain = k*max(f-f0,0);
    force=gain/1000*9.80665;

    fprintf('%g Hz: Lift difference = %.3f g-equiv. = %.5f N\n',f,gain,force);

end

% Save graph

exportgraphics(gcf,'Reizenstein_Kylee_ME482_Fig6_Graph.png','Resolution',200);
