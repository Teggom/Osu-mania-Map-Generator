Read <- "~/"
write <- "~/MusicFolderScript/SavedWAV/"
osu <- "G:/osu!/Songs/<Song Folder>/"
setwd(Read)

if(!("seewave" %in% installed.packages())){install.packages("seewave");library("seewave")}else{library("seewave")}
if(!("tuneR" %in% installed.packages())){install.packages("tuneR");library("tuneR")}else{library("tuneR")}
if(!("audio" %in% installed.packages())){install.packages("audio");library("audio")}else{library("audio")}


Build_Note <- function(Lane, Time, Single, End=0){
  if(!(Lane %in% 1:7)){stop("Error: Lane Not Identified")}
  if(Lane==1){Lane_Pos <- 36}
  if(Lane==2){Lane_Pos <- 109}
  if(Lane==3){Lane_Pos <- 182}
  if(Lane==4){Lane_Pos <- 256}
  if(Lane==5){Lane_Pos <- 329}
  if(Lane==6){Lane_Pos <- 402}
  if(Lane==7){Lane_Pos <- 475}
  if(Time<0){stop("Error: Negative Time value.")}
  if(!Single&&End<=Time){stop("Error: Long Note End value LESS than Start Value")}
  addon <- ifelse(Single, 1, 128)
  Laster <- ifelse(Single, "", paste(as.character(End), ":", sep = ""))
  return(paste(Lane_Pos, ",192,", Time, ",", addon, ",0,", Laster, "0:0:0:0:", sep = ""))
}
  
  
MKPS <- 10 # 1-70
DENSITY <- 5 # 1-10
RV <- 1 # 1-65525
Version <- 5

setwd(osu)
Text_File <- as.vector(read.table("<Generated Beatmap File name>.osu", sep = "\n")$V1)

Meta <- grepl("\\[Metadata]", Text_File)
Meta <- c(rep(x = F, 6), Meta[1:(length(Meta)-6)])
Text_File[Meta] <- paste("Version:Test", Version, sep = "")


Timing <- grepl("\\[TimingPoints]", Text_File)
Timing <- c(F, Timing[1:(length(Timing)-1)])
Timing <- Text_File[Timing]
Timing <-as.numeric(as.vector(strsplit(Timing, split = ",")[[1]])[2])

Line <- grepl("\\[HitObjects]", Text_File)
Line <- c(F, Line[1:(length(Line)-1)])
C_Time <- as.numeric(as.vector(strsplit(Text_File[Line], split = ",")[[1]])[3])

New_Notes <- c()
for(each in 1:400){
  p <- sample(x = c(T, F), size = 7, replace = T)
  C_Time <- C_Time+Timing
  spot_hit <- c()
  for(lane in 1:length(p)){
    if(p[lane]){
      spot_hit <- c(spot_hit, Build_Note(Lane = lane, Time = floor(C_Time), Single = T))
    }
  }
  New_Notes <- c(New_Notes, spot_hit)
}
Line <- grepl("\\[HitObjects]", Text_File)
while(T %in% Line){
  Line <- Line[1:(length(Line)-1)]
}
Text_File2 <- c(Text_File[1:(length(Line)+1)], New_Notes)
write(x =Text_File2, file = paste("Pillows - Ride On Shooting Star (Teggom) [Test", Version, "].osu", sep = ""))

## Some random fooling around I did with song reading

#used .WAV
#Son1 <- readWave(filename = "<Songname>.wav", from=1, to=10, units="seconds")
#Son2 <- readWave(filename = "<Songname>.wav", from=1, to=10, units = "seconds")

#n <- c()
#n2 <- c()
#Max1 <- max(Son1@left)
#Max2 <- max(Son2@left)
#for(index in 1:length(Son1@left)){
#  n <- c(n, max(Son1@left[index]/Max1, Son2@left[index]/Max2))
#  if(index%%1000==0){print(paste(index, length(Son2@left), sep = " out of "))}
#  if(length(n) > sqrt(length(Son1@left))){
#    n2 <- c(n2, n)
#    n <- c()
#  }
#}
#n2 <- c(n2, n)

#file_info <- file.info("Star.wav")
#CONNECTION <- file("Star.wav",'rb')
#x <- readBin(con = CONNECTION, raw(), size = 1, endian = 'big', n = file_info$size)
#closeAllConnections()
