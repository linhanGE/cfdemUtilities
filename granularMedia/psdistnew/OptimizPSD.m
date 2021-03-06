function OptimizPSD(percent);

global fig1 fig2 fich Vmod k n xg sg nbps rho cw area Mt cwcal dmin first nn0 dd0 percent;

figure(fig1);
Vmod=get(findobj(gcf,'Tag','PopupMenu1'),'Value');
k=get(findobj(gcf,'Tag','EditText1'),'Value');
n=get(findobj(gcf,'Tag','EditText2'),'Value');
if Vmod==5
    xg=k;
    sg=n;
    xbar=get(findobj(gcf,'Tag','EditText6'),'Value');
    sbar=get(findobj(gcf,'Tag','EditText7'),'Value');
end

figure(fig2);
Vmodfit=get(findobj(gcf,'Tag','PopupMenu1'),'Value');
if Vmodfit == 2,
    Vmod = 6;
end

nbps=get(findobj(gcf,'Tag','EditText1'),'String');
rho=str2num(get(findobj(gcf,'Tag','EditText2'),'String'));
cw=str2num(get(findobj(gcf,'Tag','EditText3'),'String'));
area=str2num(get(findobj(gcf,'Tag','EditText4'),'String'));
Mt=area/(1000000)^2*cw/1000;


for i = 1:str2num(nbps),
    VBox = strcat('EditText', num2str(i+4));
    nn(i)=str2num(get(findobj(gcf,'Tag',VBox),'String'));
    VBox = strcat('EditText', num2str(i+49));
    dd0(i)=str2num(get(findobj(gcf,'Tag',VBox),'String'));
    mm(i)=nn(i)*rho*4/3*pi*(dd0(i)/(2*1000000))^3;
end

dmin=dd0(1);
first=1
options = optimset('LargeScale','off','MaxFunEvals',10000,'MaxIter',500,'Display','iter','TolFun',3e-2);
dd = fmincon(@cwfun,dd0,[],[],[],[],[],[],@cwcon,options);
F=cwfun(dd);
[c,ceq]=cwcon(dd)
cwcal=cwcal
set(findobj(gcf,'Tag','EditText141'),'String',num2str(cwcal));

for i = 1:str2num(nbps),
    fD=0.;
    m=rho*4/3*pi*(dd(i)/(2*1000000))^3;
    if Vmod == 1,
        fd=(dd(i)^n/k^n);
        if i ~= 1,
            fD=(dd(i-1)^n/k^n);
        end
    elseif Vmod == 2,
        fd=(1-(1-dd(i)/k)^n);
        if i ~= 1,
            fD=(1-(1-dd(i-1)/k)^n);
        end
    elseif Vmod == 3,
        fd=erf(log(dd(i)/k)/n);
        if i ~= 1,
            fD=erf(log(dd(i-1)/k)/n);
        end
    elseif Vmod == 4,
        fd=(1-exp(-(dd(i)^n/k^n)));
        if i ~= 1,                
            fD=(1-exp(-(dd(i-1)^n/k^n)));
        end
    elseif Vmod == 5
        fd=1/2*(1+erf(log(dd(i)/xg)/(sqrt(2)*log(sg))));
        if i ~= 1,
            fD=1/2*(1+erf(log(dd(i-1)/xg)/(sqrt(2)*log(sg))));
        end
    elseif Vmod == 6,
        taille=size(fich,1);
        if taille ~= 0,
            d=fich(:,1);
            mp=fich(:,2);
            fd=interp1(d,mp,dd(i),'cubic')/100;
            if i ~= 1,
                fD=interp1(d,mp,dd(i-1),'cubic')/100;    
            end
        end
    end
    nn(i)=(round((fd-fD)*Mt/m));

    VBox = strcat('EditText', num2str(i+4));
    set(findobj(gcf,'Tag',VBox),'String',num2str(nn(i)));
    VBox = strcat('EditText', num2str(i+49));
    set(findobj(gcf,'Tag',VBox),'String',num2str(dd(i)));
end
