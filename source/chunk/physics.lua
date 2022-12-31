--[[ Texto en ES / Español Text: Script original do module Mestre Mandou (versão legacy 3.28), apenas para uso em cafofos da tribo. Este script requer ao menos 2 ratos no cafofo para funcionar. PROIBIDAS EDIÇÕES NO CÓDIGO NÃO AUTORIZADAS OU UTILIZAÇÃO PARA MONTAGEM DE OUTROS SCRIPTS. ]]--
language="es" -- Troque esta variável pela comunidade que você joga. / Change this variable according to your community. Available languages: br, en, ar, es
tfm.exec.disableAutoNewGame(true)
tfm.exec.disableAutoShaman(true)
tfm.exec.disableAutoTimeLeft(true)
tfm.exec.disableAutoScore(true)
tfm.exec.disableAfkDeath(true)
mapas={6788085,6788183,6789853,6791944,6792470,6808957,6810292,6821950,6830799,6866406,6866549,6788693,6788728,6859175,6834529,6866437,6812488,6876638,6876563,6885971,6888512,6893463,6900149,6907177,6892608,6982387,5328362,5957905,7055459,7290270,7290275,7404106,7404327,7382263,7394517,7405103,7400694,7400678,7412412,7412422,7431981,7354947,7525277}
active=0
vivo=0
rato=0
dificuldade=1
rodadas=0
string=""
rodada=0
number=0
xpos=0
ypos=0
data={}
lang={}
pergunta="Interval"
tempo=10
resposta=""
unlocked=true
for _,f in next,{"help","rodar","run","limite","q","time"} do
    system.disableChatCommandDisplay(f)
end
lang.br = {
    welcome = "<N>Bem-vindo a sala Mestre Mandou! Nesta sala seu objetivo é fazer tudo o que o script mandar.<ROSE><br><VP>Script criado por Jessiewind26#2546 - Versão RTM Compilação 35",
    dancar = "Dance!",
    sentar = "Sente!",
    confetar = "Atire 5 confetes!",
    mouse = "Clique na tela 10 vezes!",
    beijos = "Dê 10 beijos!",
    dormir = "Vocês estão com sono. Durmam para descansar.",
    raiva = "Tigrounette é do mal! Fiquem com raiva dele!",
    chorem = "Vocês não ganharam queijo :( Chorem!",
    esquerda = "Não vá para a esquerda!",
    direita = "Não vá para a direita!",
    numero = "Digite o seguinte número: ",
    digitar = "Digite qualquer coisa e mande para mim.",
    falar = "Não falem nada!",
    pular = "Não pulem!",
    mexer = "Não se mexam!",
    bandeira = "Balance a bandeira de qualquer país!",
    ano = "Em que ano estamos?",
    vesquerda = "Fique virado para a esquerda!",
    vdireita = "Fique virado para a direita!",
    quadradov = "Fique no quadrado vermelho!",
    quadrado = "Fique no quadrado branco!",
    retangulo = "Fique dentro do retângulo branco!",
    retangulov = "Fique dentro do retângulo vermelho!",
    nretangulo = "Não fique dentro do retângulo branco!",
    preesquerda30 = "Pressione 30 vezes a tecla para ESQUERDA!",
    predireita30 = "Pressione 30 vezes a tecla para DIREITA!",
    preesquerda60 = "Pressione 60 vezes a tecla para ESQUERDA!",
    predireita60 = "Pressione 60 vezes a tecla para DIREITA!",
    espaco = "Pressione a barra de espaço 20 vezes!",
    nome = "Digite o seu nome no jogo (com #número).",
    ndance = "Não dance!",
    mestre = "Mestre Mandou",
    map = "Mapa",
    time = "Tempo",
    mice = "Ratos",
    round = "Rodada",
    mices = "Esta sala requer pelo menos 2 ratos.",
    difficulty = "Dificuldade",
    creator = "Module criado por Jessiewind26#2546",
    segundos = "segundos.",
    fim = "Partida encerrada! Próxima partida iniciando em ",
    playingmap = "Rodando mapa",
    created = "criado por"
}
lang.en = {
    welcome = "<N>Welcome to script Master Says! On this module you have to do everything that the master says.<ROSE><br><VP>Module created by Jessiewind26#2546 - Version RTM Compilation 35",
    dancar = "Dance!",
    sentar = "Sit!",
    confetar = "Throw 5 confetti!",
    mouse = "Click on screen 10 times!",
    beijos = "Give 10 kisses!",
    dormir = "They are sleepy. Sleep to rest.",
    raiva = "Tigrounette is evil! Get angry with him!",
    chorem = "No cheese for you. Cry!",
    esquerda = "Don't go to the LEFT!",
    direita = "Don't go to the RIGHT!",
    numero = "Type this number: ",
    digitar = "Type anything and send to me.",
    falar = "Don't speak nothing!",
    pular = "Don't jump!",
    mexer = "Don't move!",
    bandeira = "Balance the flag of anything country!",
    ano = "What year are we?",
    vesquerda = "Stay facing LEFT!",
    vdireita = "Stay facing RIGHT!",
    quadradov = "Stay on the red square!",
    quadrado = "Stay on the white square!",
    retangulo = "Stay on the white rectangle!",
    retangulov = "Stay on the red rectangle!",
    nretangulo = "Don't stay on the white rectangle!",
    preesquerda30 = "Press 30 times the LEFT key!",
    predireita30 = "Press 30 times the RIGHT key!",
    preesquerda60 = "Press 60 times the LEFT key!",
    predireita60 = "Press 60 times the RIGHT key!",
    espaco = "Press 20 times the SPACEBAR!",
    nome = "Type your nickname (with #number)!",
    ndance = "Don't dance!",
    mestre = "Master Says",
    map = "Map",
    time = "Time",
    mice = "Mice",
    round = "Round",
    mices = "This room requires at least 2 players.",
    difficulty = "Difficulty",
    creator = "Module created by Jessiewind26#2546",
    segundos = "seconds.",
    fim = "End of match! The next match will start on ",
    playingmap = "Playing map",
    created = "created by"
}
lang.ar = {
welcome = "<N>????? ?? ??? ??????! ?? ??? ????? ??? ???? ??? ?? ??????? ?????? . <ROSE><br>?? ???? ???????? ?? ??????? ????? !help<br><VP>?? ??? ????? ?? ???? Jessiewind26#2546 - ??????? RTM Compilation35",
dancar = "????!",
sentar = "????!",
confetar = "??? ???? 5 ?????!",
mouse = "?? ?????? ??? ?????? 10 ????!",
beijos = "?? ???????? 10 ????!",
dormir = "???? ?????? ???????? ??? ???????!",
raiva = "????????? ????! ?? ???????? ????!",
chorem = "?? ????? ?? ???? ?? ?????? ????!",
esquerda = "?? ???? ??????!",
direita = "?? ???? ???????!",
numero = "???? ??? ????? : ",
digitar = "???? ?? ??? ?????? ??",
falar = "?? ????? ?? ??? ?? ???!",
pular = "?? ????!",
mexer = "?? ??????!",
bandeira = "???? ??? ?? ????!",
ano = "?? ?? ??? ????",
vesquerda = "???? ?????? ??????? ??????",
vdireita = "???? ?????? ??????? ??????!",
quadradov = "Stay on the red square!",
quadrado = "???? ?? ?????? ??????",
retangulo = "???? ?? ???????? ??????",
retangulov = "Stay on the red rectangle!",
nretangulo = "?? ???? ?? ???????? ??????!",
preesquerda30 = "???? 30 ??? ??? ?? ????? ??????",
predireita30 = "???? 30 ??? ??? ?? ????? ??????",
preesquerda60 = "???? 60 ??? ??? ?? ????? ??????",
predireita60 = "???? 60 ??? ??? ?? ????? ??????",
espaco = "???? 20 ??? ??? ?? ???????",
nome = "???? ???? (?? ??? ???????? #)?",
abracar = "???? ???? ??? ???!",
beijar = "??? ?????? ?? ???",
ndance = "?? ????!",
mestre = "?????? ????",
map = "?????",
time = "?????",
mice = "???????",
round = "??????",
mices = "??? ?????? ????? ??? ????? 2 ?????.",
difficulty = "???????",
creator = "???? ????? ?? ???? ?????? : Jessiewind26#2546",
segundos = "?????",
fim = "????? ??????? ?????? ??????? ??? ????? ??????! ",
playingmap = "Playing map",
created = "created by"
}
lang.es = {
welcome = "<N> Bienvenido al módulo ¡Simón dice! En este módulo tienes que hacer todo lo que dice simón. <ROSE> <br> <VP> Módulo creado por Jessiewind26#2546 - Versión RTM Compilation 35",
dancar = "¡Danza!",
sentar = "¡Sentarse!",
confetar = "¡Lanza confeti 5 veces!",
mouse = "¡Haga clic en la pantalla 10 veces!",
beijos = "¡Lanza 10 besos!",
dormir = "Tienen sueño. Duerman para descansar",
raiva = "¡Tigrounette es malvado! ¡Enójate con él!",
chorem = "No hay queso para ti. Llora!",
esquerda = "¡No vayas a la IZQUIERDA!",
direita = "¡No vayas a la DERECHA!",
numero = "Escriba este número:",
digitar = "Escribe cualquier cosa y mándamela",
falar = "¡No hables nada!",
pular = "¡No saltes!",
mexer = "¡No te muevas!",
bandeira = "¡Agita la bandera de cualquier país!",
ano = "¿En qué año estamos?",
vesquerda = "¡Quédate frente a la IZQUIERDA!",
vdireita = "¡Mantente mirando a la DERECHA!",
quadrado = "¡Quédate en el cuadrado blanco!",
quadradov = "¡Quédate en el cuadrado rojo!",
retangulo = "¡Quédate en el rectángulo blanco!",
retangulov = "¡Quédate en el rectángulo rojo!",
nretangulo = "¡No te quedes en el rectángulo blanco!",
preesquerda30 = "Presiona 30 veces la tecla IZQUIERDA!",
predireita30 = "Presiona 30 veces la tecla DERECHA!",
preesquerda60 = "Presiona 60 veces la tecla IZQUIERDA!",
predireita60 = "Presiona 60 veces la tecla DERECHA!",
espaco = "Presione 20 veces la barra espaciadora!",
nome = "Escribe tu apodo (con #numero incluido)",
ndance = "¡No bailes!",
mestre = "Simón dice",
map = "Mapa",
time = "Hora",
mice = "Ratones",
round = "Redondo",
mices = "Esta sala requiere al menos 2 jugadores",
difficulty = "Dificultad",
creator = "Módulo creado por Jessiewind26#2546",
segundos = "segundos.",
fim = "¡Fin del partido! El próximo partido comenzará el ",
playingmap = "Mapa de juego",
created = "creado por"
}
if language == "br" then
    text = lang.br
elseif language == "ar" then
    text = lang.ar
elseif language == "es" then
    text = lang.es
else
    text = lang.en
end
function eventNewPlayer(name)
    rato=rato+1
    for k=32, 87 do
        tfm.exec.bindKeyboard(name,k,false,true)
    end
    system.bindMouse(name,true)
    newData={
            ["c"]=0;
            ["s"]=0;
            };     
    data[name] = newData;
end
for name,player in pairs(tfm.get.room.playerList) do
    eventNewPlayer(name)
end
function eventPlayerDied(name)
    if active >= 0 then
        vivo=vivo-1
        local i=0
        local name
        for pname,player in pairs(tfm.get.room.playerList) do
            if not player.isDead then
                i=i+1
                name=pname
            end
        end
        if i==0 then
            active=-1
        elseif i==1 then
            active=-1
            tfm.exec.giveCheese(name)
            tfm.exec.playerVictory(name)
            tfm.exec.setGameTime(10)
        end
    end
end
function eventNewGame()
    ui.removeTextArea(0,nil)
    rodada=0
    active=0
    vivo=0
    rato=0
    dificuldade=1
    if unlocked == true then
        tfm.exec.setGameTime(15)
    else
        tfm.exec.setGameTime(36000)
    end
    for name,player in pairs(tfm.get.room.playerList) do
        vivo=vivo+1
        rato=rato+1
        if data[name] then
            data[name].c=0
            data[name].key=0
        end
    end
    rodadas=math.floor(10+(rato/3))
end
function eventPlayerLeft()
    rato=rato-1
end
function sortearComandos()
    active=math.random(1,37)
    getCommand()
end
function getCommand()
    rodada=rodada+1
    for name,player in pairs(tfm.get.room.playerList) do
        data[name].c=0
        data[name].s=0
    end
    if active == 1 then
        ui.addTextArea(0,"<font face='Segoe UI'><font color='#e5e5e5'><font size='25'><p align='center'>"..text.dancar.."",nil,25,20,750,40,0x010101,0x121212,0.96,true)
        tfm.exec.setGameTime(5)
    end
    if active == 2 then
        ui.addTextArea(0,"<font face='Segoe UI'><font color='#e5e5e5'><font size='25'><p align='center'>"..text.sentar.."",nil,25,20,750,40,0x010101,0x121212,0.96,true)
        tfm.exec.setGameTime(5)
    end
    if active == 3 then
        ui.addTextArea(0,"<font face='Segoe UI'><font color='#e5e5e5'><font size='25'><p align='center'>"..text.confetar.."",nil,25,20,750,40,0x010101,0x121212,0.96,true)
        tfm.exec.setGameTime(6)
    end
    if active == 4 then
        ui.addTextArea(0,"<font face='Segoe UI'><font color='#e5e5e5'><font size='25'><p align='center'>"..text.mouse.."",nil,25,20,750,40,0x010101,0x121212,0.96,true)
        tfm.exec.setGameTime(6)
    end
    if active == 5 then
        ui.addTextArea(0,"<font face='Segoe UI'><font color='#e5e5e5'><font size='25'><p align='center'>"..text.beijos.."",nil,25,20,750,40,0x010101,0x121212,0.96,true)
        tfm.exec.setGameTime(15)
    end
    if active == 6 then
        ui.addTextArea(0,"<font face='Segoe UI'><font color='#e5e5e5'><font size='25'><p align='center'>"..text.dormir.."",nil,25,20,750,40,0x010101,0x121212,0.96,true)
        tfm.exec.setGameTime(5)
    end
    if active == 7 then
        ui.addTextArea(0,"<font face='Segoe UI'><font color='#e5e5e5'><font size='25'><p align='center'>"..text.raiva.."",nil,25,20,750,40,0x010101,0x121212,0.96,true)
        tfm.exec.setGameTime(5)
    end
    if active == 8 then
        ui.addTextArea(0,"<font face='Segoe UI'><font color='#e5e5e5'><font size='25'><p align='center'>"..text.chorem.."",nil,25,20,750,40,0x010101,0x121212,0.96,true)
        tfm.exec.setGameTime(5)
    end
    if active == 9 then
        ui.addTextArea(0,"<font face='Segoe UI'><font color='#e5e5e5'><font size='25'><p align='center'>"..text.esquerda.."",nil,25,20,750,40,0x010101,0x121212,0.96,true)
        tfm.exec.setGameTime(8)
        for name,player in pairs(tfm.get.room.playerList) do
            data[name].c=1 -- isto indica que todos permanecerão vivos
        end
    end
    if active == 10 then
        ui.addTextArea(0,"<font face='Segoe UI'><font color='#e5e5e5'><font size='25'><p align='center'>"..text.direita.."",nil,25,20,750,40,0x010101,0x121212,0.96,true)
        tfm.exec.setGameTime(8)
        for name,player in pairs(tfm.get.room.playerList) do
            data[name].c=1
        end
    end
    if active == 11 then
        number=math.random(1000000,9999999)
        ui.addTextArea(0,"<font face='Segoe UI'><font color='#e5e5e5'><font size='25'><p align='center'>"..text.numero..""..number.."",nil,25,20,750,40,0x010101,0x121212,0.96,true)
        tfm.exec.setGameTime(10)
    end
    if active == 12 then
        ui.addTextArea(0,"<font face='Segoe UI'><font color='#e5e5e5'><font size='25'><p align='center'>"..text.digitar.."",nil,25,20,750,40,0x010101,0x121212,0.96,true)
        tfm.exec.setGameTime(7)
    end
    if active == 13 then
        number=math.random(100000000,999999999)
        ui.addTextArea(0,"<font face='Segoe UI'><font color='#e5e5e5'><font size='25'><p align='center'>"..text.numero..""..number.."",nil,25,20,750,40,0x010101,0x121212,0.96,true)
        tfm.exec.setGameTime(11)
    end
    if active == 14 then
        ui.addTextArea(0,"<font face='Segoe UI'><font color='#e5e5e5'><font size='25'><p align='center'>"..text.falar.."",nil,25,20,750,40,0x010101,0x121212,0.96,true)
        tfm.exec.setGameTime(5)
        for name,player in pairs(tfm.get.room.playerList) do
            data[name].c=1
        end
    end
    if active == 15 then
        ui.addTextArea(0,"<font face='Segoe UI'><font color='#e5e5e5'><font size='25'><p align='center'>"..text.pular.."",nil,25,20,750,40,0x010101,0x121212,0.96,true)
        tfm.exec.setGameTime(5)
        for name,player in pairs(tfm.get.room.playerList) do
            data[name].c=1
        end
    end
    if active == 16 then
        ui.addTextArea(0,"<font face='Segoe UI'><font color='#e5e5e5'><font size='25'><p align='center'>"..text.mexer.."",nil,25,20,750,40,0x010101,0x121212,0.96,true)
        tfm.exec.setGameTime(5)
        for name,player in pairs(tfm.get.room.playerList) do
            data[name].c=1
        end
    end
    if active == 17 then
        ui.addTextArea(0,"<font face='Segoe UI'><font color='#e5e5e5'><font size='25'><p align='center'>"..text.bandeira.."",nil,25,20,750,40,0x010101,0x121212,0.96,true)
        tfm.exec.setGameTime(8)
    end
    if active == 18 then
        ui.addTextArea(0,"<font face='Segoe UI'><font color='#e5e5e5'><font size='25'><p align='center'>"..text.ano.."",nil,25,20,750,40,0x010101,0x121212,0.96,true)
        tfm.exec.setGameTime(5)
    end
    if active == 19 then
        ui.addTextArea(0,"<font face='Segoe UI'><font color='#e5e5e5'><font size='25'><p align='center'>"..text.vesquerda.."",nil,25,20,750,40,0x010101,0x121212,0.96,true)
        tfm.exec.setGameTime(5)
        for name,player in pairs(tfm.get.room.playerList) do
            data[name].c=1
        end
    end
    if active == 20 then
        ui.addTextArea(0,"<font face='Segoe UI'><font color='#e5e5e5'><font size='25'><p align='center'>"..text.vdireita.."",nil,25,20,750,40,0x010101,0x121212,0.96,true)
        tfm.exec.setGameTime(5)
        for name,player in pairs(tfm.get.room.playerList) do
            data[name].c=1
        end
    end
    if active == 21 then
        xpos=math.random(60,650) -- calcula aleatoriamente a posição do quadrado branco
        ui.addTextArea(0,"<font face='Segoe UI'><font color='#e5e5e5'><font size='25'><p align='center'>"..text.quadrado.."",nil,25,20,750,40,0x010101,0x121212,0.96,true)
        tfm.exec.setGameTime(5)
        for name,player in pairs(tfm.get.room.playerList) do
            data[name].c=1
        end
        ui.addTextArea(1,"",nil,xpos,320,80,65,0xffffff,0xffffff,0.68,false)
    end
    if active == 22 then
        xpos=math.random(60,650) -- calcula aleatoriamente a posição do retângulo branco
        ui.addTextArea(0,"<font face='Segoe UI'><font color='#e5e5e5'><font size='25'><p align='center'>"..text.retangulo.."",nil,25,20,750,40,0x010101,0x121212,0.96,true)
        tfm.exec.setGameTime(5)
        for name,player in pairs(tfm.get.room.playerList) do
            data[name].c=1
        end
        ui.addTextArea(1,"",nil,xpos,0,80,400,0xffffff,0xffffff,0.68,false)
    end
    if active == 23 then
        xpos=math.random(60,650) -- calcula aleatoriamente a posição do retângulo branco
        ui.addTextArea(0,"<font face='Segoe UI'><font color='#e5e5e5'><font size='25'><p align='center'>"..text.nretangulo.."",nil,25,20,750,40,0x010101,0x121212,0.96,true)
        tfm.exec.setGameTime(5)
        for name,player in pairs(tfm.get.room.playerList) do
            data[name].c=1
        end
        ui.addTextArea(1,"",nil,xpos,0,80,400,0xffffff,0xffffff,0.68,false)
    end
    if active == 24 then
        ypos=math.random(40,300) -- calcula aleatoriamente a posição do retângulo branco
        ui.addTextArea(0,"<font face='Segoe UI'><font color='#e5e5e5'><font size='25'><p align='center'>"..text.retangulo.."",nil,25,20,750,40,0x010101,0x121212,0.96,true)
        tfm.exec.setGameTime(5)
        for name,player in pairs(tfm.get.room.playerList) do
            data[name].c=1
        end
        ui.addTextArea(1,"",nil,0,ypos,1600,60,0xffffff,0xffffff,0.68,false)
    end
    if active == 25 then
        ypos=math.random(40,300) -- calcula aleatoriamente a posição do retângulo branco
        ui.addTextArea(0,"<font face='Segoe UI'><font color='#e5e5e5'><font size='25'><p align='center'>"..text.nretangulo.."",nil,25,20,750,40,0x010101,0x121212,0.96,true)
        tfm.exec.setGameTime(5)
        for name,player in pairs(tfm.get.room.playerList) do
            data[name].c=1
        end
        ui.addTextArea(1,"",nil,0,ypos,1600,60,0xffffff,0xffffff,0.68,false)
    end
    if active == 26 then
        ui.addTextArea(0,"<font face='Segoe UI'><font color='#e5e5e5'><font size='25'><p align='center'>"..text.preesquerda30.."",nil,25,20,750,40,0x010101,0x121212,0.96,true)
        tfm.exec.setGameTime(9)
    end
    if active == 27 then
        ui.addTextArea(0,"<font face='Segoe UI'><font color='#e5e5e5'><font size='25'><p align='center'>"..text.predireita30.."",nil,25,20,750,40,0x010101,0x121212,0.96,true)
        tfm.exec.setGameTime(9)
    end
    if active == 28 then
        ui.addTextArea(0,"<font face='Segoe UI'><font color='#e5e5e5'><font size='25'><p align='center'>"..text.preesquerda60.."",nil,25,20,750,40,0x010101,0x121212,0.96,true)
        tfm.exec.setGameTime(15)
    end
    if active == 29 then
        ui.addTextArea(0,"<font face='Segoe UI'><font color='#e5e5e5'><font size='25'><p align='center'>"..text.predireita60.."",nil,25,20,750,40,0x010101,0x121212,0.96,true)
        tfm.exec.setGameTime(15)
    end
    if active == 30 then
        ui.addTextArea(0,"<font face='Segoe UI'><font color='#e5e5e5'><font size='25'><p align='center'>"..text.espaco.."",nil,25,20,750,40,0x010101,0x121212,0.96,true)
        tfm.exec.setGameTime(7)
    end
    if active == 31 then
        ui.addTextArea(0,"<font face='Segoe UI'><font color='#e5e5e5'><font size='25'><p align='center'>"..text.nome.."",nil,25,20,750,40,0x010101,0x121212,0.96,true)
        tfm.exec.setGameTime(12)
    end
    if active == 32 then
        ui.addTextArea(0,"<font face='Segoe UI'><font color='#e5e5e5'><font size='25'><p align='center'>"..text.ndance.."",nil,25,20,750,40,0x010101,0x121212,0.96,true)
        tfm.exec.setGameTime(6)
        for name,player in pairs(tfm.get.room.playerList) do
            data[name].c=1
        end
    end
    if active == 33 then
        ui.addTextArea(0,"<font face='Segoe UI'><font color='#e5e5e5'><font size='25'><p align='center'>"..pergunta.."",nil,25,20,750,40,0x010101,0x121212,0.96,true)
        tfm.exec.setGameTime(tempo)
        for name,player in pairs(tfm.get.room.playerList) do
            data[name].c=1
        end
    end
    if active == 34 then
        xpos=math.random(60,650) -- calcula aleatoriamente a posição do quadrado branco
        local xpos2=math.random(60,650) -- calcula aleatoriamente a posição do quadrado vermelho
        ui.addTextArea(0,"<font face='Segoe UI'><font color='#e5e5e5'><font size='25'><p align='center'>"..text.quadrado.."",nil,25,20,750,40,0x010101,0x121212,0.96,true)
        tfm.exec.setGameTime(5)
        for name,player in pairs(tfm.get.room.playerList) do
            data[name].c=1
        end
        ui.addTextArea(1,"",nil,xpos,320,80,65,0xffffff,0xffffff,0.68,false)
        ui.addTextArea(2,"",nil,xpos2,320,80,65,0xff0000,0xff0000,0.62,false)
    end
    if active == 35 then
        xpos=math.random(60,650) -- calcula aleatoriamente a posição do quadrado branco
        local xpos2=math.random(60,650) -- calcula aleatoriamente a posição do quadrado vermelho
        ui.addTextArea(0,"<font face='Segoe UI'><font color='#e5e5e5'><font size='25'><p align='center'>"..text.quadradov.."",nil,25,20,750,40,0x010101,0x121212,0.96,true)
        tfm.exec.setGameTime(5)
        for name,player in pairs(tfm.get.room.playerList) do
            data[name].c=1
        end
        ui.addTextArea(1,"",nil,xpos2,320,80,65,0xffffff,0xffffff,0.68,false)
        ui.addTextArea(2,"",nil,xpos,320,80,65,0xff0000,0xff0000,0.62,false)
    end
    if active == 36 then
        xpos=math.random(60,650) -- calcula aleatoriamente a posição do quadrado branco
        local xpos2=math.random(60,650) -- calcula aleatoriamente a posição do quadrado vermelho
        ui.addTextArea(0,"<font face='Segoe UI'><font color='#e5e5e5'><font size='25'><p align='center'>"..text.retangulo.."",nil,25,20,750,40,0x010101,0x121212,0.96,true)
        tfm.exec.setGameTime(5)
        for name,player in pairs(tfm.get.room.playerList) do
            data[name].c=1
        end
        ui.addTextArea(1,"",nil,xpos,0,80,400,0xffffff,0xffffff,0.68,false)
        ui.addTextArea(2,"",nil,xpos2,0,80,400,0xff0000,0xff0000,0.62,false)
    end
    if active == 37 then
        xpos=math.random(60,650) -- calcula aleatoriamente a posição do quadrado branco
        local xpos2=math.random(60,650) -- calcula aleatoriamente a posição do quadrado vermelho
        ui.addTextArea(0,"<font face='Segoe UI'><font color='#e5e5e5'><font size='25'><p align='center'>"..text.retangulov.."",nil,25,20,750,40,0x010101,0x121212,0.96,true)
        tfm.exec.setGameTime(5)
        for name,player in pairs(tfm.get.room.playerList) do
            data[name].c=1
        end
        ui.addTextArea(1,"",nil,xpos2,0,80,400,0xffffff,0xffffff,0.68,false)
        ui.addTextArea(2,"",nil,xpos,0,80,400,0xff0000,0xff0000,0.62,false)
    end
end
function eventChatMessage(name,message)
    if active == 11 or active == 13 then
        if message == tostring(number) or message == string then
            data[name].c=1
        end
    end
    if active == 12 then
        data[name].c=1
    end
    if active == 14 then
        tfm.exec.killPlayer(name)
    end
    if active == 18 then
        if message == "2022" then
            data[name].c=1
        end
    end
    if active == 31 then
        if string.upper(message) == string.upper(name) then
            data[name].c=1
        end
    end
end
function eventEmotePlayed(name,id)
    if active == 1 then
        if id == 0 or id == 10 then
            data[name].c=1
        end
    end
    if active == 2 then
        if id == 8 then
            data[name].c=1
        end
    end
    if active == 3 then
        if id == 9 then
            data[name].s=data[name].s+1
            if data[name].s >= 5 then
                data[name].c=1
            end
        end
    end
    if active == 5 then
        if id == 3 then
            data[name].s=data[name].s+1
            if data[name].s >= 10 then
                data[name].c=1
            end
        end
    end
    if active == 6 then
        if id == 6 then
            data[name].c=1
        end
    end
    if active == 7 then
        if id == 4 then
            data[name].c=1
        end
    end
    if active == 8 then
        if id == 2 then
            data[name].c=1
        end
    end
    if active == 16 then
        tfm.exec.killPlayer(name)
    end
    if active == 17 then
        if id == 10 then
            data[name].c=1
        end
    end
    if active == 32 then
        if id == 0 or id == 10 then
            tfm.exec.killPlayer(name)
        end
    end
end
function eventMouse(name,x,y)
    if active == 4 then
        data[name].s=data[name].s+1
        if data[name].s >= 10 then
            data[name].c=1
        end
    end
end
function eventKeyboard(name,id,down,x,y)
    if active == 9 then
        if id == 37 or id == 65 then
            tfm.exec.killPlayer(name)
        end
    end
    if active == 10 then
        if id == 39 or id == 68 then
            tfm.exec.killPlayer(name)
        end
    end
    if active == 15 then
        if id == 38 or id == 87 then
            tfm.exec.killPlayer(name)
        end
    end
    if active == 16 then
        tfm.exec.killPlayer(name)
    end
    if active == 26 then
        if id == 37 or id == 65 then
            if data[name].key == 0 then
                data[name].key=id
            end
            data[name].s=data[name].s+1
            if data[name].s >= 30 then
                data[name].c=1
            end
        end
        if data[name].key == 37 and id == 65 then
            tfm.exec.killPlayer(name)
        end
        if data[name].key == 65 and id == 37 then
            tfm.exec.killPlayer(name)
        end
    end
    if active == 27 then
        if id == 39 or id == 68 then
            if data[name].key == 0 then
                data[name].key=id
            end
            data[name].s=data[name].s+1
            if data[name].s >= 30 then
                data[name].c=1
            end
        end
        if data[name].key == 39 and id == 68 then
            tfm.exec.killPlayer(name)
        end
        if data[name].key == 68 and id == 39 then
            tfm.exec.killPlayer(name)
        end
    end
    if active == 28 then
        if id == 37 or id == 65 then
            if data[name].key == 0 then
                data[name].key=id
            end
            data[name].s=data[name].s+1
            if data[name].s >= 60 then
                data[name].c=1
            end
        end
        if data[name].key == 37 and id == 65 then
            tfm.exec.killPlayer(name)
        end
        if data[name].key == 65 and id == 37 then
            tfm.exec.killPlayer(name)
        end
    end
    if active == 29 then
        if id == 39 or id == 68 then
            if data[name].key == 0 then
                data[name].key=id
            end
            data[name].s=data[name].s+1
            if data[name].s >= 60 then
                data[name].c=1
            end
        end
        if data[name].key == 39 and id == 68 then
            tfm.exec.killPlayer(name)
        end
        if data[name].key == 68 and id == 39 then
            tfm.exec.killPlayer(name)
        end
    end
    if active == 34 then
        if id == 37 or id == 65 then
            if data[name].key == 0 then
                data[name].key=id
            end
            data[name].s=data[name].s+1
            if data[name].s >= 200 then
                data[name].c=1
            end
        end
        if data[name].key == 37 and id == 65 then
            tfm.exec.killPlayer(name)
        end
        if data[name].key == 65 and id == 37 then
            tfm.exec.killPlayer(name)
        end
    end
    if active == 35 then
        if id == 39 or id == 68 then
            if data[name].key == 0 then
                data[name].key=id
            end
            data[name].s=data[name].s+1
            if data[name].s >= 200 then
                data[name].c=1
            end
        end
        if data[name].key == 39 and id == 68 then
            tfm.exec.killPlayer(name)
        end
        if data[name].key == 68 and id == 39 then
            tfm.exec.killPlayer(name)
        end
    end
    if active == 30 then
        if id == 32 then
            data[name].s=data[name].s+1
            if data[name].s >= 15 then
                data[name].c=1
            end
        end
    end
end
function eventLoop(passado,faltando)
    local tempo=math.floor(faltando/1000)
    if active == -2 then
        ui.setMapName("<N>"..text.mices.."<")
    elseif active == -1 then
        ui.setMapName("<VP>"..text.fim.."<b>"..tempo.."</b> "..text.segundos.."<")
    end
    if rato < 2 then
        if tfm.get.room.currentMap == "@7277839" and unlocked == true then
            active=-2
            tfm.exec.setGameTime(8000)
        else
            if passado > 3000 and unlocked == true then
                tfm.exec.newGame("@7277839")
                tfm.exec.setGameTime(8000)
            end
        end
    end
    if rato >= 2 then
        if tfm.get.room.currentMap == "@7277839" and unlocked == true then
            tfm.exec.newGame(mapas[math.random(#mapas)])
            active=0
        end
    end
    if active < 0 and faltando < 1 and unlocked == true then
        tfm.exec.newGame(mapas[math.random(#mapas)])
    end
    if active == 0 and faltando < 1000 then
        if rodada < rodadas then
            sortearComandos()
        else
            active=-1
            tfm.exec.setGameTime(10)
            for name,player in pairs(tfm.get.room.playerList) do
                tfm.exec.giveCheese(true)
                tfm.exec.playerVictory(true)
            end
        end
    end
    if active > 0 and faltando < 1 and rato > 1 then
        if active == 19 then
            for name,player in pairs(tfm.get.room.playerList) do
                if tfm.get.room.playerList[name].isFacingRight == true then
                    tfm.exec.killPlayer(name)
                end
            end
        end
        if active == 20 then
            for name,player in pairs(tfm.get.room.playerList) do
                if tfm.get.room.playerList[name].isFacingRight == false then
                    tfm.exec.killPlayer(name)
                end
            end
        end
        if active == 21 or active == 34 then
            for name,player in pairs(tfm.get.room.playerList) do
                if player.y < 300 then
                    tfm.exec.killPlayer(name)
                else
                    if player.x < xpos-20 or player.x > xpos+100 then
                        tfm.exec.killPlayer(name)
                    end
                end
            end
        end
        if active == 35 then
            for name,player in pairs(tfm.get.room.playerList) do
                if player.y < 300 then
                    tfm.exec.killPlayer(name)
                else
                    if player.x < xpos-20 or player.x > xpos+100 then
                        tfm.exec.killPlayer(name)
                    end
                end
            end
        end
        if active == 22 or active == 36 or active == 37 then
            for name,player in pairs(tfm.get.room.playerList) do
                if player.x < xpos or player.x > xpos+80 then
                    tfm.exec.killPlayer(name)
                end
            end
        end
        if active == 23 then
            for name,player in pairs(tfm.get.room.playerList) do
                if player.x > xpos and player.x < xpos+80 then
                    tfm.exec.killPlayer(name)
                end
            end
        end
        if active == 24 then
            for name,player in pairs(tfm.get.room.playerList) do
                if player.y < ypos-10 or player.y > ypos+70 then
                    tfm.exec.killPlayer(name)
                end
            end
        end
        if active == 25 then
            for name,player in pairs(tfm.get.room.playerList) do
                if player.y > ypos-10 and player.y < ypos+70 then
                    tfm.exec.killPlayer(name)
                end
            end
        end
        ui.removeTextArea(0,nil)
        ui.removeTextArea(1,nil)
        ui.removeTextArea(2,nil)
        active=0
        if rodada == 4 or rodada == 6 or rodada == 8 or rodada == 10 then
            dificuldade=dificuldade+1
        end
        for name,player in pairs(tfm.get.room.playerList) do
            data[name].key=0
            if data[name].c == 0 then
                tfm.exec.killPlayer(name)
            end
        end
        if vivo > 4 then
            tfm.exec.setGameTime(6-dificuldade)
        else
            tfm.exec.setGameTime(9-dificuldade)
        end
    end
    for name,player in pairs(tfm.get.room.playerList) do
        if data[name].c == 1 then
            tfm.exec.setNameColor(name,0x00ff00)
        else
            tfm.exec.setNameColor(name,0xc2c2da)
        end
    end
end
tfm.exec.newGame("@7277839")