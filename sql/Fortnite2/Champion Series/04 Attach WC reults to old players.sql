USE Fortnite
GO

-- BEFORE THIS, MADE d:\Fortnite\Fortnitedb\August 29.bak

-- Set All WC Finalists to NA East for now
UPDATE Placement SET RegionID = 3 WHERE WeekID = 12
UPDATE Placement SET RegionID = 3 WHERE WeekID = 11

-- For wrong format for WC Solo
UPDATE Week SET FormatID = 1 WHERE ID = 12


UPDATE PlayerPlacement Set PlayerID = 31 WHERE ID = 166637 -- Bugha


SELECT 
	'UPDATE PlayerPlacement SET PlayerID =  WHERE ID = ' + CONVERT (varchar(20), pp.ID) + ' -- ' + CurrentName
FROM PlayerPlacement pp
JOIN Player p ON pp.PlayerID = p.ID
JOIN Placement pl ON pp.PlacementID = pl.ID
WHERE pl.WeekID = 12


SELECT * FROM PlayerView WHERE Nationality = 'Argentina'

UPDATE PlayerPlacement SET PlayerID =  WHERE ID = 166637 -- SEN Bughа
UPDATE PlayerPlacement SET PlayerID = 8863 WHERE ID = 166638 -- psalm
UPDATE PlayerPlacement SET PlayerID = 14705 WHERE ID = 166639 -- EpikWhale
UPDATE PlayerPlacement SET PlayerID = 86 WHERE ID = 166640 -- Kreo
UPDATE PlayerPlacement SET PlayerID = 69174 WHERE ID = 166641 -- KING
UPDATE PlayerPlacement SET PlayerID = 28889 WHERE ID = 166642 -- Crue
UPDATE PlayerPlacement SET PlayerID = 29205 WHERE ID = 166643 -- Skite
UPDATE PlayerPlacement SET PlayerID = 1169 WHERE ID = 166644 -- Nayte
UPDATE PlayerPlacement SET PlayerID = 11834 WHERE ID = 166645 -- Riversan
UPDATE PlayerPlacement SET PlayerID = 3199 WHERE ID = 166646 -- Fatch
UPDATE PlayerPlacement SET PlayerID = 11888 WHERE ID = 166647 -- Rhux
UPDATE PlayerPlacement SET PlayerID = 29599 WHERE ID = 166648 -- Tchub
UPDATE PlayerPlacement SET PlayerID = 28853 WHERE ID = 166649 -- Mongraal
UPDATE PlayerPlacement SET PlayerID = 28756 WHERE ID = 166650 -- stompy
UPDATE PlayerPlacement SET PlayerID = 1053 WHERE ID = 166651 -- Dubs
UPDATE PlayerPlacement SET PlayerID = 11718 WHERE ID = 166652 -- Pika
UPDATE PlayerPlacement SET PlayerID = 28780 WHERE ID = 166653 -- BELAEU
UPDATE PlayerPlacement SET PlayerID = 16 WHERE ID = 166654 -- Clix
UPDATE PlayerPlacement SET PlayerID = 57041 WHERE ID = 166655 -- Peterpan
UPDATE PlayerPlacement SET PlayerID = 165432 WHERE ID = 166656 -- commandment
UPDATE PlayerPlacement SET PlayerID = 30040 WHERE ID = 166657 -- Domentos
UPDATE PlayerPlacement SET PlayerID = 28939 WHERE ID = 166658 -- Skailereu
UPDATE PlayerPlacement SET PlayerID = 186 WHERE ID = 166659 -- Bizzle
UPDATE PlayerPlacement SET PlayerID = 30501 WHERE ID = 166660 -- Endretta
UPDATE PlayerPlacement SET PlayerID = 28788 WHERE ID = 166661 -- benjyfishy

UPDATE PlayerPlacement SET PlayerID = 28852   WHERE ID = 166662 -- Kinstaar
UPDATE PlayerPlacement SET PlayerID = 68996 WHERE ID = 166663 -- kurtz
UPDATE PlayerPlacement SET PlayerID = 117 WHERE ID = 166664 -- Klass
UPDATE PlayerPlacement SET PlayerID = 28789 WHERE ID = 166665 -- MrSavage
UPDATE PlayerPlacement SET PlayerID = 28898 WHERE ID = 166666 -- K1nzell
UPDATE PlayerPlacement SET PlayerID = 28920 WHERE ID = 166667 -- fwexY
UPDATE PlayerPlacement SET PlayerID = 29833 WHERE ID = 166668 -- Letshe
UPDATE PlayerPlacement SET PlayerID = 56497 WHERE ID = 166669 -- TAKAMURAMM
UPDATE PlayerPlacement SET PlayerID = 20722 WHERE ID = 166670 -- Pzuhs
UPDATE PlayerPlacement SET PlayerID = 49 WHERE ID = 166671 -- RogueShark
UPDATE PlayerPlacement SET PlayerID = 191 WHERE ID = 166672 -- Zayt
UPDATE PlayerPlacement SET PlayerID = 28809 WHERE ID = 166673 -- Issa
UPDATE PlayerPlacement SET PlayerID = 12 WHERE ID = 166674 -- Vivid
UPDATE PlayerPlacement SET PlayerID = 14752 WHERE ID = 166675 -- storm
UPDATE PlayerPlacement SET PlayerID = 28857 WHERE ID = 166676 -- DiegoGB
UPDATE PlayerPlacement SET PlayerID = 30014 WHERE ID = 166677 -- LeftEye
UPDATE PlayerPlacement SET PlayerID = 7722 WHERE ID = 166678 -- kolorful
UPDATE PlayerPlacement SET PlayerID = 29049 WHERE ID = 166679 -- teeq
UPDATE PlayerPlacement SET PlayerID = 29225 WHERE ID = 166680 -- smeef
UPDATE PlayerPlacement SET PlayerID =  WHERE ID = 166681 -- DRG    -- ??????




UPDATE PlayerPlacement SET PlayerID = 165458 WHERE ID = 166682 -- PrisiOn3rO
UPDATE PlayerPlacement SET PlayerID = 28884 WHERE ID = 166683 -- Klusia
UPDATE PlayerPlacement SET PlayerID = 29063 WHERE ID = 166684 -- wakie
UPDATE PlayerPlacement SET PlayerID = 28782 WHERE ID = 166685 -- CoreGamingg
UPDATE PlayerPlacement SET PlayerID = 3040 WHERE ID = 166686 -- Chenkinz
UPDATE PlayerPlacement SET PlayerID = 68969 WHERE ID = 166687 -- Nicks
UPDATE PlayerPlacement SET PlayerID = 28787 WHERE ID = 166688 -- JarkoS
UPDATE PlayerPlacement SET PlayerID = 14684 WHERE ID = 166689 -- Arkhram1x
UPDATE PlayerPlacement SET PlayerID = 165466 WHERE ID = 166690 -- Evilmare
UPDATE PlayerPlacement SET PlayerID = 56628 WHERE ID = 166691 -- Hood.J
UPDATE PlayerPlacement SET PlayerID = 81 WHERE ID = 166692 -- clarityG
UPDATE PlayerPlacement SET PlayerID = 69079 WHERE ID = 166693 -- leleo
UPDATE PlayerPlacement SET PlayerID = 28936 WHERE ID = 166694 -- lolbOom
UPDATE PlayerPlacement SET PlayerID = 28913 WHERE ID = 166695 -- letw1k3
UPDATE PlayerPlacement SET PlayerID = 183 WHERE ID = 166696 -- Ceice
UPDATE PlayerPlacement SET PlayerID = 124 WHERE ID = 166697 -- Aspect
UPDATE PlayerPlacement SET PlayerID = 1174 WHERE ID = 166698 -- Megga
UPDATE PlayerPlacement SET PlayerID = 29247 WHERE ID = 166699 -- Fledermoys
UPDATE PlayerPlacement SET PlayerID = 874 WHERE ID = 166700 -- Bucke
UPDATE PlayerPlacement SET PlayerID = 56631 WHERE ID = 166701 -- Banny
UPDATE PlayerPlacement SET PlayerID = 165478 WHERE ID = 166702 -- Emqu
UPDATE PlayerPlacement SET PlayerID = 82 WHERE ID = 166703 -- Tfue
UPDATE PlayerPlacement SET PlayerID = 165480 WHERE ID = 166704 -- sozmann
UPDATE PlayerPlacement SET PlayerID = 165481 WHERE ID = 166705 -- UnknownxArmy
UPDATE PlayerPlacement SET PlayerID = 3683 WHERE ID = 166706 -- Kawzmik
UPDATE PlayerPlacement SET PlayerID = 69066 WHERE ID = 166707 -- Lasers


UPDATE PlayerPlacement SET PlayerID = 32970 WHERE ID = 166708 -- Erouce
UPDATE PlayerPlacement SET PlayerID = 56607 WHERE ID = 166709 -- FaxFox
UPDATE PlayerPlacement SET PlayerID =  WHERE ID = 166710 -- snow    --- ????


SELECT * FROM Player WHERE CurrentName Like '%arius%'


UPDATE PlayerPlacement SET PlayerID = 165487 WHERE ID = 166711 -- drakiNz
UPDATE PlayerPlacement SET PlayerID = 5529 WHERE ID = 166712 -- Touzii
UPDATE PlayerPlacement SET PlayerID = 94 WHERE ID = 166713 -- Luneze
UPDATE PlayerPlacement SET PlayerID =  WHERE ID = 166714 -- slaya   --- ????
UPDATE PlayerPlacement SET PlayerID = 28907 WHERE ID = 166715 -- Blax
UPDATE PlayerPlacement SET PlayerID = 33802 WHERE ID = 166716 -- LYGHT
UPDATE PlayerPlacement SET PlayerID = 28887 WHERE ID = 166717 -- BlastR
UPDATE PlayerPlacement SET PlayerID = 29089 WHERE ID = 166718 -- luki
UPDATE PlayerPlacement SET PlayerID = 43609 WHERE ID = 166719 -- Link
UPDATE PlayerPlacement SET PlayerID = 165496 WHERE ID = 166720 -- marteen
UPDATE PlayerPlacement SET PlayerID = 165497 WHERE ID = 166721 -- karhu
UPDATE PlayerPlacement SET PlayerID = 31860 WHERE ID = 166722 -- Robabz
UPDATE PlayerPlacement SET PlayerID = 273 WHERE ID = 166723 -- Astonish
UPDATE PlayerPlacement SET PlayerID = 29082 WHERE ID = 166724 -- Snayzy
UPDATE PlayerPlacement SET PlayerID = 114 WHERE ID = 166725 -- Legedien
UPDATE PlayerPlacement SET PlayerID = 165502 WHERE ID = 166726 -- Revers2k
UPDATE PlayerPlacement SET PlayerID = 56763 WHERE ID = 166727 -- Maufin
UPDATE PlayerPlacement SET PlayerID = 125 WHERE ID = 166728 -- Nittle
UPDATE PlayerPlacement SET PlayerID = 165505 WHERE ID = 166729 -- Hornet
UPDATE PlayerPlacement SET PlayerID = 28838 WHERE ID = 166730 -- aqua
UPDATE PlayerPlacement SET PlayerID = 43635 WHERE ID = 166731 -- Cat
UPDATE PlayerPlacement SET PlayerID = 43556 WHERE ID = 166732 -- twins
UPDATE PlayerPlacement SET PlayerID =  WHERE ID = 166733 -- Herrions   -- ?
UPDATE PlayerPlacement SET PlayerID = 69114 WHERE ID = 166734 -- Clipnode
UPDATE PlayerPlacement SET PlayerID = 104 WHERE ID = 166735 -- Funk
UPDATE PlayerPlacement SET PlayerID = 56630 WHERE ID = 166736 -- Arius



--- duos


SELECT 
	'UPDATE PlayerPlacement SET PlayerID =  WHERE ID = ' + CONVERT (varchar(20), pp.ID) + ' -- ' + CurrentName
FROM PlayerPlacement pp
JOIN Player p ON pp.PlayerID = p.ID
JOIN Placement pl ON pp.PlacementID = pl.ID
WHERE pl.WeekID = 12





UPDATE PlayerPlacement SET PlayerID = 154  WHERE ID = 166542 -- Saf
UPDATE PlayerPlacement SET PlayerID = 28804 WHERE ID = 166547 -- Mitr0
UPDATE PlayerPlacement SET PlayerID = 102 WHERE ID = 166591 -- XXiF
UPDATE PlayerPlacement SET PlayerID = 29298 WHERE ID = 166601 -- 7ssk7
UPDATE PlayerPlacement SET PlayerID = 28756 WHERE ID = 166585 -- stompy
UPDATE PlayerPlacement SET PlayerID = 28789 WHERE ID = 166563 -- MrSavage
UPDATE PlayerPlacement SET PlayerID = 68969 WHERE ID = 166629 -- Nicks
UPDATE PlayerPlacement SET PlayerID = 165299 WHERE ID = 166567 -- Calculator
UPDATE PlayerPlacement SET PlayerID = 16 WHERE ID = 166605 -- Clix
UPDATE PlayerPlacement SET PlayerID = 415 WHERE ID = 166553 -- Vinny1x
UPDATE PlayerPlacement SET PlayerID = 69125 WHERE ID = 166631 -- GusTavox8
UPDATE PlayerPlacement SET PlayerID = 28852 WHERE ID = 166580 -- Kinstaar
UPDATE PlayerPlacement SET PlayerID = 28858 WHERE ID = 166581 -- Hunter
UPDATE PlayerPlacement SET PlayerID = 128 WHERE ID = 166602 -- Tetchra
UPDATE PlayerPlacement SET PlayerID =  WHERE ID = 166619 -- Puzz  -- ?
UPDATE PlayerPlacement SET PlayerID = 191 WHERE ID = 166543 -- Zayt
UPDATE PlayerPlacement SET PlayerID =  WHERE ID = 166612 -- KING -- ?
UPDATE PlayerPlacement SET PlayerID = 28853 WHERE ID = 166546 -- Mongraal
UPDATE PlayerPlacement SET PlayerID = 23 WHERE ID = 166540 -- Elevate
UPDATE PlayerPlacement SET PlayerID = 28929  WHERE ID = 166536 -- Nyhrox
UPDATE PlayerPlacement SET PlayerID = 28838 WHERE ID = 166537 -- aqua

UPDATE PlayerPlacement SET PlayerID = 165314  WHERE ID = 166538 -- Rojo
UPDATE PlayerPlacement SET PlayerID = 28862 WHERE ID = 166539 -- Wolfiez
UPDATE PlayerPlacement SET PlayerID = 183 WHERE ID = 166541 -- Ceice
UPDATE PlayerPlacement SET PlayerID = 14684 WHERE ID = 166544 -- Arkhram1x
UPDATE PlayerPlacement SET PlayerID = 14777 WHERE ID = 166545 -- Falconer
UPDATE PlayerPlacement SET PlayerID = 1174 WHERE ID = 166548 -- Megga
UPDATE PlayerPlacement SET PlayerID = 1053 WHERE ID = 166549 -- Dubs
UPDATE PlayerPlacement SET PlayerID = 28775 WHERE ID = 166550 -- Derox
UPDATE PlayerPlacement SET PlayerID = 28825 WHERE ID = 166551 -- itemm
UPDATE PlayerPlacement SET PlayerID = 438 WHERE ID = 166552 -- Zexrow
UPDATE PlayerPlacement SET PlayerID = 29304 WHERE ID = 166554 -- Vato
UPDATE PlayerPlacement SET PlayerID = 29205 WHERE ID = 166555 -- Skite
UPDATE PlayerPlacement SET PlayerID =  WHERE ID = 166556 -- Deadra  -- ?
UPDATE PlayerPlacement SET PlayerID = 28830 WHERE ID = 166557 -- M11Z
UPDATE PlayerPlacement SET PlayerID = 14705 WHERE ID = 166558 -- EpikWhale
UPDATE PlayerPlacement SET PlayerID = 14752 WHERE ID = 166559 -- storm
UPDATE PlayerPlacement SET PlayerID = 31687 WHERE ID = 166560 -- Noward
UPDATE PlayerPlacement SET PlayerID =  28845 WHERE ID = 166561 -- 4zr
UPDATE PlayerPlacement SET PlayerID =  28788 WHERE ID = 166562 -- benjyfishy
UPDATE PlayerPlacement SET PlayerID =  67 WHERE ID = 166564 -- Keys
UPDATE PlayerPlacement SET PlayerID =  134 WHERE ID = 166565 -- Slackes
UPDATE PlayerPlacement SET PlayerID =  344 WHERE ID = 166566 -- MackWood
UPDATE PlayerPlacement SET PlayerID =  WHERE ID = 166568 -- Spades  -- ?
UPDATE PlayerPlacement SET PlayerID =  57 WHERE ID = 166569 -- Crimz
UPDATE PlayerPlacement SET PlayerID =  43654 WHERE ID = 166570 -- hype
UPDATE PlayerPlacement SET PlayerID =  43594 WHERE ID = 166571 -- Serpennt
UPDATE PlayerPlacement SET PlayerID =  29400 WHERE ID = 166572 -- BadSniper



UPDATE PlayerPlacement SET PlayerID = 29245 WHERE ID = 166573 -- Oslo
UPDATE PlayerPlacement SET PlayerID = 56464 WHERE ID = 166574 -- Scarlet
UPDATE PlayerPlacement SET PlayerID = 56516 WHERE ID = 166575 -- bell
UPDATE PlayerPlacement SET PlayerID = 28746 WHERE ID = 166576 -- Th0masHD
UPDATE PlayerPlacement SET PlayerID = 28884 WHERE ID = 166577 -- Klusia
UPDATE PlayerPlacement SET PlayerID = 28932 WHERE ID = 166578 -- Chapix
UPDATE PlayerPlacement SET PlayerID = 28889 WHERE ID = 166579 -- Crue
UPDATE PlayerPlacement SET PlayerID = 34830 WHERE ID = 166582 -- znappy
UPDATE PlayerPlacement SET PlayerID = 29380 WHERE ID = 166583 -- RedRush
UPDATE PlayerPlacement SET PlayerID = 28743 WHERE ID = 166584 -- Tschinken
UPDATE PlayerPlacement SET PlayerID = 29334 WHERE ID = 166586 -- Tuckz
UPDATE PlayerPlacement SET PlayerID = 29759 WHERE ID = 166587 -- Vorwenn
UPDATE PlayerPlacement SET PlayerID =  WHERE ID = 166588 -- KBB  -- ?
UPDATE PlayerPlacement SET PlayerID = 165365 WHERE ID = 166589 -- YuWang
UPDATE PlayerPlacement SET PlayerID = 64 WHERE ID = 166590 -- ronaldo
UPDATE PlayerPlacement SET PlayerID = 165368 WHERE ID = 166592 -- Nikof
UPDATE PlayerPlacement SET PlayerID = 28919 WHERE ID = 166593 -- Airwaks
UPDATE PlayerPlacement SET PlayerID = 45 WHERE ID = 166594 -- Lanjok
UPDATE PlayerPlacement SET PlayerID = 19 WHERE ID = 166595 -- Punisher
UPDATE PlayerPlacement SET PlayerID = 110 WHERE ID = 166596 -- Nate Hill
UPDATE PlayerPlacement SET PlayerID = 104  WHERE ID = 166597 -- Funk
UPDATE PlayerPlacement SET PlayerID = 28913 WHERE ID = 166598 -- letw1k3
UPDATE PlayerPlacement SET PlayerID = 28920 WHERE ID = 166599 -- fwexY


UPDATE PlayerPlacement SET PlayerID = 29175 WHERE ID = 166600 -- JAMSIDE
UPDATE PlayerPlacement SET PlayerID = 131 WHERE ID = 166603 -- Eclipsae
UPDATE PlayerPlacement SET PlayerID = 174 WHERE ID = 166604 -- Sceptic
UPDATE PlayerPlacement SET PlayerID = 182 WHERE ID = 166606 -- CizLucky
UPDATE PlayerPlacement SET PlayerID = 159 WHERE ID = 166607 -- Brush
UPDATE PlayerPlacement SET PlayerID = 14793 WHERE ID = 166608 -- Aydan
UPDATE PlayerPlacement SET PlayerID = 14772 WHERE ID = 166609 -- Sean
UPDATE PlayerPlacement SET PlayerID = 14751 WHERE ID = 166610 -- little
UPDATE PlayerPlacement SET PlayerID = 14771 WHERE ID = 166611 -- jay
UPDATE PlayerPlacement SET PlayerID = 69217 WHERE ID = 166613 -- xown
UPDATE PlayerPlacement SET PlayerID = 165390 WHERE ID = 166614 -- parpy
UPDATE PlayerPlacement SET PlayerID = 43751 WHERE ID = 166615 -- volx
UPDATE PlayerPlacement SET PlayerID = 14795 WHERE ID = 166616 -- Leno
UPDATE PlayerPlacement SET PlayerID = 14764 WHERE ID = 166617 -- Barl
UPDATE PlayerPlacement SET PlayerID =  WHERE ID = 166618 -- Ming  --- ???
UPDATE PlayerPlacement SET PlayerID = 24 WHERE ID = 166620 -- LeNain
UPDATE PlayerPlacement SET PlayerID = 139 WHERE ID = 166621 -- Tyler15
UPDATE PlayerPlacement SET PlayerID =  WHERE ID = 166622 -- Quinten -- ?
UPDATE PlayerPlacement SET PlayerID = 29172 WHERE ID = 166623 -- Lnuef
UPDATE PlayerPlacement SET PlayerID = 28890 WHERE ID = 166624 -- Skram
UPDATE PlayerPlacement SET PlayerID = 28908 WHERE ID = 166625 -- Mexe
UPDATE PlayerPlacement SET PlayerID = 32 WHERE ID = 166626 -- RoAtDW
UPDATE PlayerPlacement SET PlayerID = 38 WHERE ID = 166627 -- BlooTea
UPDATE PlayerPlacement SET PlayerID = 68989 WHERE ID = 166628 -- pfzin
UPDATE PlayerPlacement SET PlayerID = 71479 WHERE ID = 166630 -- wisheydp
UPDATE PlayerPlacement SET PlayerID = 56642 WHERE ID = 166632 -- xMende
UPDATE PlayerPlacement SET PlayerID = 56533 WHERE ID = 166633 -- XXM
UPDATE PlayerPlacement SET PlayerID = 43683 WHERE ID = 166634 -- CoverH
UPDATE PlayerPlacement SET PlayerID = 43629 WHERE ID = 166635 -- Twizz





SELECT 
	'UPDATE Placement SET PlayerID =  WHERE ID = ' + CONVERT (varchar(20), pp.ID) + ' -- ' + CurrentName
FROM PlayerPlacement pp
JOIN Player p ON pp.PlayerID = p.ID
JOIN Placement pl ON pp.PlacementID = pl.ID
WHERE pl.WeekID in (11, 12)


SELECT 'UPDATE Placement SET RegionID =  WHERE ID = ' + CONVERT (varchar(20), p.ID) + ' -- ' + pl.CurrentName 
FROM Placement p
JOIN PlayerPlacement pp ON p.ID = pp.placementID
JOIN player pl ON pl.ID = pp.PlayerID
WHERE p.WeekID IN (11,12)

1	TBD	TBD
2	Oceania	OCE
3	NA East	NAE
4	NA West	NAW
5	Europe	EU
6	Brazil	BR
7	Asia	ASIA
8	Middle East	ME

UPDATE Placement SET RegionID = 3 WHERE ID = 125044 -- Liquid Vivid
UPDATE Placement SET RegionID = 3 WHERE ID = 125024 -- MSF Clix
UPDATE Placement SET RegionID = 3 WHERE ID = 124990 -- MSF Clix
UPDATE Placement SET RegionID = 3 WHERE ID = 124985 -- coL Punisher
UPDATE Placement SET RegionID = 3 WHERE ID = 124958 -- 100T Elevate
UPDATE Placement SET RegionID = 3 WHERE ID = 124998 -- Envy LeNain
UPDATE Placement SET RegionID = 3 WHERE ID = 125007 -- SEN Bughа
UPDATE Placement SET RegionID = 3 WHERE ID = 125001 -- RoAtDW
UPDATE Placement SET RegionID = 3 WHERE ID = 125001 -- E11 BlooTea
UPDATE Placement SET RegionID = 3 WHERE ID = 124985 -- coL Lanjok
UPDATE Placement SET RegionID = 3 WHERE ID = 125041 -- RogueShark_
UPDATE Placement SET RegionID = 3 WHERE ID = 124972 -- woofgang crimz
UPDATE Placement SET RegionID = 3 WHERE ID = 124983 -- code ronaldo
UPDATE Placement SET RegionID = 3 WHERE ID = 124970 -- KeysFN
UPDATE Placement SET RegionID = 3 WHERE ID = 125062 -- RS clarityG
UPDATE Placement SET RegionID = 3 WHERE ID = 125073 -- Tfue
UPDATE Placement SET RegionID = 3 WHERE ID = 125010 -- LZR Kreo
UPDATE Placement SET RegionID = 3 WHERE ID = 125083 -- Thiccboy Luneze
UPDATE Placement SET RegionID = 3 WHERE ID = 124983 -- XXiF
UPDATE Placement SET RegionID = 3 WHERE ID = 124986 -- FaZe Funk
UPDATE Placement SET RegionID = 3 WHERE ID = 125105 -- FaZe Funk
UPDATE Placement SET RegionID = 3 WHERE ID = 124986 -- Nate Hill
UPDATE Placement SET RegionID = 3 WHERE ID = 125095 -- Legedien
UPDATE Placement SET RegionID = 3 WHERE ID = 125034 -- 100T Klass
UPDATE Placement SET RegionID = 3 WHERE ID = 125067 -- CODE SEN-Aspect
UPDATE Placement SET RegionID = 3 WHERE ID = 125098 -- Nittle
UPDATE Placement SET RegionID = 3 WHERE ID = 124989 -- Tetchra
UPDATE Placement SET RegionID = 3 WHERE ID = 124989 -- Eclipsae
UPDATE Placement SET RegionID = 3 WHERE ID = 124970 -- Slackes
UPDATE Placement SET RegionID = 3 WHERE ID = 124998 -- LG Tyler15
UPDATE Placement SET RegionID = 4 WHERE ID = 124959 -- Ghost Saf
UPDATE Placement SET RegionID = 3 WHERE ID = 124991 -- Tempo Brush
UPDATE Placement SET RegionID = 5 WHERE ID = 124990 -- MSF Sceptic
UPDATE Placement SET RegionID = 3 WHERE ID = 124991 -- Tempo CizLucky
UPDATE Placement SET RegionID = 3 WHERE ID = 124958 -- 100T Ceice
UPDATE Placement SET RegionID = 3 WHERE ID = 125066 -- 100T Ceice
UPDATE Placement SET RegionID = 3 WHERE ID = 125029 -- Ghost Bizzle
UPDATE Placement SET RegionID = 3 WHERE ID = 125042 -- NRG Zayt
UPDATE Placement SET RegionID = 3 WHERE ID = 124959 -- NRG Zayt
UPDATE Placement SET RegionID = 3 WHERE ID = 125093 -- Astonishㅤㅤㅤㅤ
UPDATE Placement SET RegionID = 3 WHERE ID = 124971 -- coL MackWood
UPDATE Placement SET RegionID = 4 WHERE ID = 124964 -- TSM.Vinny1x
UPDATE Placement SET RegionID = 3 WHERE ID = 124964 -- TSM_Zexrow
UPDATE Placement SET RegionID = 3 WHERE ID = 125070 -- Envy Bucke
UPDATE Placement SET RegionID = 3 WHERE ID = 124962 -- FaZe Dubs.
UPDATE Placement SET RegionID = 3 WHERE ID = 125021 -- FaZe Dubs.
UPDATE Placement SET RegionID = 3 WHERE ID = 125014 -- Naytt YT
UPDATE Placement SET RegionID = 3 WHERE ID = 124962 -- FaZe Megga.
UPDATE Placement SET RegionID = 3 WHERE ID = 125068 -- FaZe Megga.
UPDATE Placement SET RegionID = 3 WHERE ID = 125056 -- Chenkinz.tv
UPDATE Placement SET RegionID = 3 WHERE ID = 125016 -- Fatch.
UPDATE Placement SET RegionID = 3 WHERE ID = 125076 -- Kawzmik
UPDATE Placement SET RegionID = 3 WHERE ID = 125082 -- Touzii
UPDATE Placement SET RegionID = 3 WHERE ID = 125048 -- RS kolorful
UPDATE Placement SET RegionID = 4 WHERE ID = 125008 -- CLG psalm
UPDATE Placement SET RegionID = 4 WHERE ID = 125022 -- 1400 Pika
UPDATE Placement SET RegionID = 4 WHERE ID = 125015 -- Liquid Riversan
UPDATE Placement SET RegionID = 4 WHERE ID = 125017 -- WBG Rhux
UPDATE Placement SET RegionID = 4 WHERE ID = 124960 -- Arkhram1x
UPDATE Placement SET RegionID = 4 WHERE ID = 125059 -- Arkhram1x
UPDATE Placement SET RegionID = 4 WHERE ID = 124967 -- KNG EpikWhale
UPDATE Placement SET RegionID = 4 WHERE ID = 125009 -- KNG EpikWhale
UPDATE Placement SET RegionID = 4  WHERE ID = 124993 -- KNG little
UPDATE Placement SET RegionID = 4 WHERE ID = 124967 -- 4DRStorm.
UPDATE Placement SET RegionID = 4 WHERE ID = 125045 -- 4DRStorm.
UPDATE Placement SET RegionID = 4 WHERE ID = 124996 -- KNG Barl
UPDATE Placement SET RegionID = 4 WHERE ID = 124993 -- KNG Jay.
UPDATE Placement SET RegionID = 4 WHERE ID = 124992 -- Ghost Sean
UPDATE Placement SET RegionID = 4 WHERE ID = 124960 -- Bloom Falconer
UPDATE Placement SET RegionID = 4 WHERE ID = 124992 -- Ghost Aydan
UPDATE Placement SET RegionID = 4 WHERE ID = 124996 -- KNG Leno
UPDATE Placement SET RegionID = 4 WHERE ID = 125040 -- USE CODE PZUHS
UPDATE Placement SET RegionID = 5 WHERE ID = 124980 -- E11 Tschiiinken
UPDATE Placement SET RegionID = 5 WHERE ID = 124976 -- SNG Th0masHD
UPDATE Placement SET RegionID = 5 WHERE ID = 124980 -- E11 Stompy
UPDATE Placement SET RegionID = 5 WHERE ID = 125020 -- E11 Stompy
UPDATE Placement SET RegionID = 5 WHERE ID = 124963 -- Derox.
UPDATE Placement SET RegionID = 5 WHERE ID = 125023 -- hREDS BELAEU
UPDATE Placement SET RegionID = 5 WHERE ID = 125055 -- TTVCoreGamingg
UPDATE Placement SET RegionID = 5 WHERE ID = 125058 -- AGO JarkoS
UPDATE Placement SET RegionID = 5 WHERE ID = 125031 -- NRG benjуfishу
UPDATE Placement SET RegionID = 5 WHERE ID = 124969 -- NRG benjуfishу
UPDATE Placement SET RegionID = 5 WHERE ID = 124969 -- NRG MrSavageM
UPDATE Placement SET RegionID = 5 WHERE ID = 125035 -- NRG MrSavageM
UPDATE Placement SET RegionID = 5 WHERE ID = 124961 -- Atlantis Mitr0
UPDATE Placement SET RegionID = 5 WHERE ID = 125043 -- Ghost Issa
UPDATE Placement SET RegionID = 5 WHERE ID = 124963 -- E11 itemm
UPDATE Placement SET RegionID = 5 WHERE ID = 124966 -- GO M11Z
UPDATE Placement SET RegionID = 5 WHERE ID = 124956 -- COOLER aquaㅤㅤ
UPDATE Placement SET RegionID = 5 WHERE ID = 125100 -- COOLER aquaㅤㅤ
UPDATE Placement SET RegionID = 5 WHERE ID = 124968 -- BTL 4zr
UPDATE Placement SET RegionID = 5 WHERE ID = 124978 -- Solary Kinstaar
UPDATE Placement SET RegionID = 5 WHERE ID = 125032 -- Solary Kinstaar
UPDATE Placement SET RegionID = 5 WHERE ID = 125019 -- Secret_Mongraal
UPDATE Placement SET RegionID = 5 WHERE ID = 124961 -- Secret_Mongraal
UPDATE Placement SET RegionID = 5 WHERE ID = 125046 -- DiegoGB uwu
UPDATE Placement SET RegionID = 5 WHERE ID = 124978 -- Solary Hunter
UPDATE Placement SET RegionID = 5 WHERE ID = 124957 -- Wolfiеz
UPDATE Placement SET RegionID = 5 WHERE ID = 124976 -- Klusiabtw
UPDATE Placement SET RegionID = 5 WHERE ID = 125053 -- Klusiabtw
UPDATE Placement SET RegionID = 5 WHERE ID = 125087 -- TrainH BlastRR
UPDATE Placement SET RegionID = 5 WHERE ID = 125012 -- VHV Crue
UPDATE Placement SET RegionID = 5 WHERE ID = 124977 -- VHV Crue
UPDATE Placement SET RegionID = 5 WHERE ID = 125000 -- Lootboy Skram
UPDATE Placement SET RegionID = 5 WHERE ID = 125036 -- Atlantis K1nzell
UPDATE Placement SET RegionID = 5 WHERE ID = 125085 -- LeStream Blaxou
UPDATE Placement SET RegionID = 5 WHERE ID = 125000 -- Lootboy Mexe
UPDATE Placement SET RegionID = 5 WHERE ID = 124987 -- Gambit.letw1k3
UPDATE Placement SET RegionID = 5 WHERE ID = 125065 -- Gambit.letw1k3
UPDATE Placement SET RegionID = 5 WHERE ID = 124984 -- Solary Airwaks
UPDATE Placement SET RegionID = 5 WHERE ID = 124987 -- Gambit.fwexY
UPDATE Placement SET RegionID = 5 WHERE ID = 125037 -- Gambit.fwexY
UPDATE Placement SET RegionID = 5 WHERE ID = 124956 -- COOLER Nyhrox
UPDATE Placement SET RegionID = 5 WHERE ID = 124977 -- VHV Chapix
UPDATE Placement SET RegionID = 5 WHERE ID = 125064 -- lolb0om
UPDATE Placement SET RegionID = 5 WHERE ID = 125028 -- Skāilereu
UPDATE Placement SET RegionID = 5 WHERE ID = 125049 -- dMIND.teeq
UPDATE Placement SET RegionID = 5 WHERE ID = 125054 -- Eon wakie
UPDATE Placement SET RegionID = 5 WHERE ID = 125094 -- Snayzy
UPDATE Placement SET RegionID = 5 WHERE ID = 125088 -- luKi tjk
UPDATE Placement SET RegionID = 5 WHERE ID = 124999 -- Lnuef
UPDATE Placement SET RegionID = 5 WHERE ID = 124988 -- VP JAMSIDE
UPDATE Placement SET RegionID = 5 WHERE ID = 124965 -- LeStream Skite
UPDATE Placement SET RegionID = 5 WHERE ID = 125013 -- LeStream Skite
UPDATE Placement SET RegionID = 5 WHERE ID = 125050 -- Fnatic smeef
UPDATE Placement SET RegionID = 5 WHERE ID = 124974 -- Oslo.
UPDATE Placement SET RegionID = 5 WHERE ID = 125069 -- Fledermoys
UPDATE Placement SET RegionID = 5 WHERE ID = 124988 -- VP 7ssk7
UPDATE Placement SET RegionID = 5 WHERE ID = 124965 -- LeStream Vato
UPDATE Placement SET RegionID = 5 WHERE ID = 124981 -- Atlantis Tuckz
UPDATE Placement SET RegionID = 5 WHERE ID = 124979 -- Eon RedRush
UPDATE Placement SET RegionID = 5 WHERE ID = 124974 -- Not BadSniper
UPDATE Placement SET RegionID = 3 WHERE ID = 125018 -- Tchub_
UPDATE Placement SET RegionID = 5 WHERE ID = 124981 -- FaZe Vorwenn
UPDATE Placement SET RegionID = 5 WHERE ID = 125038 -- Atlantis Lеtshe
UPDATE Placement SET RegionID = 5 WHERE ID = 125047 -- RBK LeftEye
UPDATE Placement SET RegionID = 5 WHERE ID = 125027 -- Secret_Domentos
UPDATE Placement SET RegionID = 5 WHERE ID = 125030 -- Xypher Endretta
UPDATE Placement SET RegionID = 5 WHERE ID = 124968 -- Noward.
UPDATE Placement SET RegionID = 5 WHERE ID = 125092 -- TrainH Robabz
UPDATE Placement SET RegionID = 5 WHERE ID = 125078 -- Erouce
UPDATE Placement SET RegionID = 5 WHERE ID = 125086 -- LYGHT ツ
UPDATE Placement SET RegionID = 5 WHERE ID = 124979 -- Eon znappy
UPDATE Placement SET RegionID = 2 WHERE ID = 125102 -- twins iwnl
UPDATE Placement SET RegionID = 2 WHERE ID = 124973 -- BES Serpennt
UPDATE Placement SET RegionID = 2 WHERE ID = 125089 -- Linkㅤㅤㅤ
UPDATE Placement SET RegionID = 2 WHERE ID = 125005 -- Code Twizz
UPDATE Placement SET RegionID = 2 WHERE ID = 125101 -- Cat 夢
UPDATE Placement SET RegionID = 2 WHERE ID = 124973 -- BES Hype
UPDATE Placement SET RegionID = 2 WHERE ID = 125005 -- CoverH
UPDATE Placement SET RegionID = 2 WHERE ID = 124995 -- Code Volx
UPDATE Placement SET RegionID = 7 WHERE ID = 124975 -- CODE CR-Scarlet
UPDATE Placement SET RegionID = 7 WHERE ID = 125039 -- CR.がちがち TAKAMURA
UPDATE Placement SET RegionID = 7 WHERE ID = 124975 -- CR.がちがち bell
UPDATE Placement SET RegionID = 7 WHERE ID = 125004 -- NewbeeXXM
UPDATE Placement SET RegionID = 7 WHERE ID = 125079 -- TOP_がちがち FaxFox
UPDATE Placement SET RegionID = 7 WHERE ID = 125061 -- Meta Hood.J
UPDATE Placement SET RegionID = 7 WHERE ID = 125106 -- T1 Arius iwnl
UPDATE Placement SET RegionID = 7 WHERE ID = 125071 -- TOP_Banny iwnl
UPDATE Placement SET RegionID = 7 WHERE ID = 125004 -- Newbee_xMende
UPDATE Placement SET RegionID = 7 WHERE ID = 125097 -- Maufin xd
UPDATE Placement SET RegionID = 7 WHERE ID = 125025 -- Meta Peterpan
UPDATE Placement SET RegionID = 6 WHERE ID = 125057 -- CODE NICKSSS
UPDATE Placement SET RegionID = 6 WHERE ID = 125002 -- CODE NICKSSS
UPDATE Placement SET RegionID = 6 WHERE ID = 125002 -- pfzin
UPDATE Placement SET RegionID = 6 WHERE ID = 125033 -- kurтz
UPDATE Placement SET RegionID = 6 WHERE ID = 125077 -- Lasers s2 Igo
UPDATE Placement SET RegionID = 6 WHERE ID = 125063 -- CODE leleo
UPDATE Placement SET RegionID = 6 WHERE ID = 125104 -- Clipnode
UPDATE Placement SET RegionID = 6 WHERE ID = 125003 -- GusTavox8
UPDATE Placement SET RegionID = 6 WHERE ID = 125011 -- 9z kıng
UPDATE Placement SET RegionID = 6 WHERE ID = 124994 -- xown iwnl-
UPDATE Placement SET RegionID = 6 WHERE ID = 125003 -- wisheydp
--UPDATE Placement SET RegionID =  WHERE ID = 124971 -- Calculator
UPDATE Placement SET RegionID = 7 WHERE ID = 124997 -- Puzz
UPDATE Placement SET RegionID = 6 WHERE ID = 124994 -- KING
UPDATE Placement SET RegionID = 6 WHERE ID = 124957 -- Rojo
--UPDATE Placement SET RegionID =  WHERE ID = 124966 -- Deadra
--UPDATE Placement SET RegionID =  WHERE ID = 124972 -- Spades
--UPDATE Placement SET RegionID =  WHERE ID = 124982 -- KBB
--UPDATE Placement SET RegionID =  WHERE ID = 124982 -- YuWang
--UPDATE Placement SET RegionID =  WHERE ID = 124984 -- Nikof
--UPDATE Placement SET RegionID =  WHERE ID = 124995 -- parpy
UPDATE Placement SET RegionID = 7 WHERE ID = 124997 -- Ming
UPDATE Placement SET RegionID = 4 WHERE ID = 124999 -- Quinten
--UPDATE Placement SET RegionID =  WHERE ID = 125026 -- commandment
UPDATE Placement SET RegionID = 6 WHERE ID = 125051 -- DRG
UPDATE Placement SET RegionID = 6 WHERE ID = 125052 -- PrisiOn3rO
UPDATE Placement SET RegionID = 5 WHERE ID = 125060 -- Evilmare
UPDATE Placement SET RegionID = 5 WHERE ID = 125072 -- Emqu
UPDATE Placement SET RegionID = 5 WHERE ID = 125074 -- sozmann
--UPDATE Placement SET RegionID =  WHERE ID = 125075 -- UnknownxArmy
--UPDATE Placement SET RegionID =  WHERE ID = 125080 -- snow
--UPDATE Placement SET RegionID =  WHERE ID = 125081 -- drakiNz
--UPDATE Placement SET RegionID =  WHERE ID = 125084 -- slaya
--UPDATE Placement SET RegionID =  WHERE ID = 125090 -- marteen
--UPDATE Placement SET RegionID =  WHERE ID = 125091 -- karhu
UPDATE Placement SET RegionID = 3 WHERE ID = 125096 -- Revers2k
UPDATE Placement SET RegionID = 3 WHERE ID = 125099 -- Hornet
--UPDATE Placement SET RegionID =  WHERE ID = 125103 -- Herrions


--2	Oceania	OCE
--3	NA East	NAE
--4	NA West	NAW
--5	Europe	EU
--6	Brazil	BR
--7	Asia	ASIA
--8	Middle East	ME




