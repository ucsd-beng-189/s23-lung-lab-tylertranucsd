%filename: lung.m (main program)
clear all
clf
global Pstar cstar n maxcount M Q camax RT cI;

%% Task 3

clear all
clf
global Pstar cstar n maxcount M Q camax RT cI;

PIplot = [];
Pabar1plot = [];
PAbar2plot = [];
Pvplot = [];
betaplot = 0:0.01:1;

for beta = 0:0.01:1
    setup_lung
    cvsolve
    outchecklung
    PIplot = [PIplot PI];
    Pabar1plot = [Pabar1plot Pabar1];
    PAbar2plot = [PAbar2plot PAbar2];
    Pvplot = [Pvplot Pv];
end

figure(1)
plot(betaplot, PIplot, ".")
hold on
plot(betaplot, Pabar1plot, ".")
plot(betaplot,PAbar2plot, ".")
plot(betaplot, Pvplot, ".")
title("beta vs. Partial Pressures of O_2")
xlabel("beta")
ylabel("Partial Pressures (mmHg)")
legend P_I P_a P_A P_v

%% Task 4
% checking the max M for each beta value from 0:0.01:1
clear all
clf
global Pstar cstar n maxcount M Q camax RT cI;
% rate of oxygen consumption (moles/minute):

cref=0.2/(22.4*(310/273));
maxMs = [];
M = 0.25*cref*5.6;

for beta = 0:0.01:1
    M = 0.25*cref*5.6;
    setup_lung
    cvsolve
    outchecklung
    while Mdiff(0,r)<0
        cvsolve
        outchecklung
        M = M + 0.001;
    end
    maxMs = [maxMs M];
end

betaplot = 0:0.01:1;
figure()
plot(betaplot,maxMs,".")
title("beta vs. Max Sustainable Oxygen Consumption M")
xlabel("beta")
ylabel("Max Sustainable Oxygen Consumption (moles/minute)")

%% Task 5
% seeing the effects of altitude (change in cI)
clear all
clf
global Pstar cstar n maxcount M Q camax RT cI;
cref=0.2/(22.4*(310/273));
cI=cref;
PAbar2plot = []; % mean alveolar partial pressure
Pabar1plot = []; % mean arterial partial pressure
Pvplot = []; % venous partial pressure
cvplot = []; % venous o2 concentration
cabar1plot = []; % mean arterial o2 concentration
cAbar2plot = []; % mean alveolar o2 concentration


for cI = cref:-0.0001:0.004;
    setup_lung
    cvsolve
    outchecklung
    cvplot = [cvplot cv];
    cabar1plot = [cabar1plot cabar1];
    cAbar2plot = [cAbar2plot cAbar2];
    PAbar2plot = [PAbar2plot PAbar2];
    Pabar1plot = [Pabar1plot Pabar1];
    Pvplot = [Pvplot Pv];
end

cIplot = cref:-0.0001:0.004
figure(1)
plot(cIplot, PAbar2plot, ".")
hold on
plot(cIplot, Pvplot, ".")
plot(cIplot, Pabar1plot, ".")
title("Conc. O_2 in Inspired Air vs. Partial Pressures of O_2")
xlabel("Concentration of O_2 in Inspired Air (moles/L)")
ylabel("Partial Pressure of O_2 [mmHg]")
legend P_A P_v P_a
figure(2)
plot(cIplot, cvplot, ".")
hold on
plot(cIplot, cAbar2plot, ".")
plot(cIplot, cabar1plot, ".")
title("Conc. of O_2 in Inspired Air vs. Concentrations of O_2")
xlabel("Concentration of O_2 in Inspired Air (moles/L)")
ylabel("Concentrations of O_2 [moles]")
legend c_v c_A c_a

%% Task 6
% seeing the effects of altitude (change in PI)

clear all
clf
global Pstar cstar n maxcount M Q camax RT cI;


cref=0.2/(22.4*(310/273));
RT=760*22.4*(310/273);
cI=cref;
PAbar2plot = []; % mean alveolar partial pressure
Pabar1plot = []; % mean arterial partial pressure
Pvplot = []; % venous partial pressure
cvplot = []; % venous o2 concentration
cabar1plot = []; % mean arterial o2 concentration
cAbar2plot = []; % mean alveolar o2 concentration


for PI = RT*cI:-1:1;
    setup_lung
    cvsolve
    outchecklung
    cvplot = [cvplot cv];
    cabar1plot = [cabar1plot cabar1];
    cAbar2plot = [cAbar2plot cAbar2];
    PAbar2plot = [PAbar2plot PAbar2];
    Pabar1plot = [Pabar1plot Pabar1];
    Pvplot = [Pvplot Pv];
end

PIplot = RT*cI:-1.12:1;
figure(1)
plot(PIplot, PAbar2plot, ".")
hold on
plot(PIplot, Pvplot, ".")
plot(PIplot, Pabar1plot, ".")
title("Partial Pressure O_2 in Inspired Air vs. Partial Pressures of O_2")
xlabel("Partial Pressure O_2 in Inspired Air [mmHg]")
ylabel("Partial Pressure of O_2 [mmHg]")
legend P_A P_v P_a
figure(2)
plot(PIplot, cvplot, ".")
hold on
plot(PIplot, cAbar2plot, ".")
plot(PIplot, cabar1plot, ".")
title("Partial Pressure O_2 in Inspired Air vs. Concentrations of O_2")
xlabel("Partial Pressure O_2 in Inspired Air [mmHg]")
ylabel("Concentrations of O_2 [moles]")
legend c_v c_A c_a

%% Task 7
% observing someone who is used to living at high altitude

clear all
clf
global Pstar cstar n maxcount M Q camax RT cI;


cref=0.2/(22.4*(310/273));
RT=760*22.4*(310/273);
cI=cref;
cstar=1.5*cref;
PAbar2plot = []; % mean alveolar partial pressure
Pabar1plot = []; % mean arterial partial pressure
Pvplot = []; % venous partial pressure
cvplot = []; % venous o2 concentration
cabar1plot = []; % mean arterial o2 concentration
cAbar2plot = []; % mean alveolar o2 concentration


for PI = RT*cI:-1:1;
    setup_lung
    cvsolve
    outchecklung
    cvplot = [cvplot cv];
    cabar1plot = [cabar1plot cabar1];
    cAbar2plot = [cAbar2plot cAbar2];
    PAbar2plot = [PAbar2plot PAbar2];
    Pabar1plot = [Pabar1plot Pabar1];
    Pvplot = [Pvplot Pv];
end

PIplot = RT*cI:-1.09:1;
figure(1)
plot(PIplot, PAbar2plot, ".")
hold on
plot(PIplot, Pvplot, ".")
plot(PIplot, Pabar1plot, ".")
title("Partial Pressure O_2 in Inspired Air vs. Partial Pressures of O_2")
xlabel("Partial Pressure O_2 in Inspired Air [mmHg]")
ylabel("Partial Pressure of O_2 [mmHg]")
legend P_A P_v P_a
figure(2)
plot(PIplot, cvplot, ".")
hold on
plot(PIplot, cAbar2plot, ".")
plot(PIplot, cabar1plot, ".")
title("Partial Pressure O_2 in Inspired Air vs. Concentrations of O_2")
xlabel("Partial Pressure O_2 in Inspired Air [mmHg]")
ylabel("Concentrations of O_2 [moles]")
legend c_v c_A c_a

%% Task 8
% assessing how someone is a pulmonary embolism causing hypoperfusion
% affects the ventilation-perfusion matching
% adjusting values of beta

clear all
clf
global Pstar cstar n maxcount M Q camax RT cI;

beta = 1;
cref=0.2/(22.4*(310/273));
RT=760*22.4*(310/273);
cI=cref;
PAbar2plot = []; % mean alveolar partial pressure
Pabar1plot = []; % mean arterial partial pressure
Pvplot = []; % venous partial pressure
cvplot = []; % venous o2 concentration
cabar1plot = []; % mean arterial o2 concentration
cAbar2plot = []; % mean alveolar o2 concentration


for PI = RT*cI:-1:1;
    setup_lung
    cvsolve
    outchecklung
    cvplot = [cvplot cv];
    cabar1plot = [cabar1plot cabar1];
    cAbar2plot = [cAbar2plot cAbar2];
    PAbar2plot = [PAbar2plot PAbar2];
    Pabar1plot = [Pabar1plot Pabar1];
    Pvplot = [Pvplot Pv];
end

PIplot = RT*cI:-1.16:1;
figure(1)
plot(PIplot, PAbar2plot, ".")
hold on
plot(PIplot, Pvplot, ".")
plot(PIplot, Pabar1plot, ".")
title("Partial Pressure O_2 in Inspired Air vs. Partial Pressures of O_2 (Beta = 1)")
xlabel("Partial Pressure O_2 in Inspired Air [mmHg]")
ylabel("Partial Pressure of O_2 [mmHg]")
legend P_A P_v P_a
figure(2)
plot(PIplot, cvplot, ".")
hold on
plot(PIplot, cAbar2plot, ".")
plot(PIplot, cabar1plot, ".")
title("Partial Pressure O_2 in Inspired Air vs. Concentrations of O_2 (Beta = 1)")
xlabel("Partial Pressure O_2 in Inspired Air [mmHg]")
ylabel("Concentrations of O_2 [moles]")
legend c_v c_A c_a

%% Task 9
% observing a change in the hemoglobin concentration in blood
% (reducing cstar)

clear all
clf
global Pstar cstar n maxcount M Q camax RT cI;

beta = 1;
cref=0.2/(22.4*(310/273));
RT=760*22.4*(310/273);
cI=cref;
PAbar2plot = []; % mean alveolar partial pressure
Pabar1plot = []; % mean arterial partial pressure
Pvplot = []; % venous partial pressure
cvplot = []; % venous o2 concentration
cabar1plot = []; % mean arterial o2 concentration
cAbar2plot = []; % mean alveolar o2 concentration
PIplot = [];
cIplot = [];


for cstar = 0.1:-0.001:0.0001;
    setup_lung
    cvsolve
    outchecklung
    cvplot = [cvplot cv];
    cIplot = [cIplot cI];
    cabar1plot = [cabar1plot cabar1];
    cAbar2plot = [cAbar2plot cAbar2];
    PAbar2plot = [PAbar2plot PAbar2];
    Pabar1plot = [Pabar1plot Pabar1];
    Pvplot = [Pvplot Pv];
    PIplot = [PIplot PI];
end

cstarplot = 0.1:-0.001:0.0035;
figure(1)
plot(cstarplot, PAbar2plot, ".")
hold on
plot(cstarplot, Pvplot, ".")
plot(cstarplot, Pabar1plot, ".")
plot(cstarplot, PIplot, ".")
title("cstar vs. Partial Pressures of O_2 (beta = 1)")
xlabel("cstar")
ylabel("Partial Pressure of O_2 [mmHg]")
legend P_A P_v P_a P_I
figure(2)
plot(cstarplot, cvplot, ".")
hold on
plot(cstarplot, cAbar2plot, ".")
plot(cstarplot, cabar1plot, ".")
plot(cstarplot, cIplot, ".")
title("cstar vs. Concentrations of O_2 (beta = 1)")
xlabel("cstar")
ylabel("Concentrations of O_2 [moles]")
legend c_v c_A c_a c_I

%% Task 10
%simulating an anemic patient
% so cstar is lower

clear all
clf
global Pstar cstar n maxcount M Q camax RT cI;
cref=0.2/(22.4*(310/273));
RT=760*22.4*(310/273);
cI=cref;
% PI=RT*cI;
cstar = 0.5*cref; % cstar is lower to simulate anemia
PAbar2plot = []; % mean alveolar partial pressure
Pabar1plot = []; % mean arterial partial pressure
Pvplot = []; % venous partial pressure
cvplot = []; % venous o2 concentration
cabar1plot = []; % mean arterial o2 concentration
cAbar2plot = []; % mean alveolar o2 concentration


for PI = RT*cI:-1:1;
    setup_lung
    cvsolve
    outchecklung
    cvplot = [cvplot cv];
    cabar1plot = [cabar1plot cabar1];
    cAbar2plot = [cAbar2plot cAbar2];
    PAbar2plot = [PAbar2plot PAbar2];
    Pabar1plot = [Pabar1plot Pabar1];
    Pvplot = [Pvplot Pv];
end

PIplot = RT*cI:-1.2:1;
figure(1)
plot(PIplot, PAbar2plot, ".")
hold on
plot(PIplot, Pvplot, ".")
plot(PIplot, Pabar1plot, ".")
title("Partial Pressure O_2 in Inspired Air vs. Partial Pressures of O_2")
xlabel("Partial Pressure O_2 in Inspired Air [mmHg]")
ylabel("Partial Pressure of O_2 [mmHg]")
legend P_A P_v P_a
figure(2)
plot(PIplot, cvplot, ".")
hold on
plot(PIplot, cAbar2plot, ".")
plot(PIplot, cabar1plot, ".")
title("Partial Pressure O_2 in Inspired Air vs. Concentrations of O_2")
xlabel("Partial Pressure O_2 in Inspired Air [mmHg]")
ylabel("Concentrations of O_2 [moles]")
legend c_v c_A c_a