library(tidyverse)

placements <- read_csv("C:/project/fortnite/r/power-ranking-tiers/data.csv")
placements


europe_cs_week_1 <- placements %>%
  filter(Event == "CS Week 1")

p <- ggplot(data = europe_cs_week_1, mapping = aes(x = Rank, y = Payout, color = Region))

p + geom_point() +
  facet_wrap(~ Region, nrow = 1)



fcs <- placements %>%
  filter(Match == "Fortnite Champion Series")

p <- ggplot(data = fcs, mapping = aes(x = Rank, y = Payout, color = Region))

p + geom_point() +
  facet_grid(Region ~ Event)
  facet_wrap(~ Region, nrow = 1)
  
  
  
fcs <- placements %>%
  filter(Match == "Fortnite Champion Series")
  
ggplot() +
  geom_point(
    data = fcs, 
    mapping = aes(x = Rank, y = Payout, color = Region)
  ) +
  facet_grid(Region ~ Event)
  


fcs <- placements %>%
  filter(Match == "Fortnite Champion Series")

ggplot() +
  geom_point(
    data = fcs, 
    mapping = aes(x = Rank, y = Payout, color = Region)
  ) +
  geom_point(
    data = fcs, 
    mapping = aes(x = Rank, y = Points)
  ) +
  facet_grid(Region ~ Event)



fcs <- placements %>%
  filter(Match == "Fortnite Champion Series" & Region == "Europe")

ggplot() +
  geom_point(
    data = fcs, 
    mapping = aes(x = Rank, y = Payout, color = Region)
  ) +
  geom_point(
    data = fcs, 
    mapping = aes(x = Rank, y = Points)
  ) +
  facet_wrap(~ Event, nrow = 1)


###
fcs <- placements %>%
  filter(Match == "Fortnite Champion Series")

ggplot() +
  geom_point(
    data = fcs, 
    mapping = aes(x = Rank, y = Payout, color = Region),
    scale = scale_y_log10()
  ) +
  geom_point(
    data = fcs, 
    mapping = aes(x = Rank, y = Points),
    scale = scale_y_log10()
  ) +
  facet_grid(Event ~ Region)


###
fcs <- placements %>%
  filter(Match == "Fortnite Champion Series")

ggplot() +
  geom_point(
    data = fcs, 
    mapping = aes(x = Rank, y = Payout, color = Region, size = 0.2)
  ) +
  geom_point(
    data = fcs, 
    mapping = aes(x = Rank, y = Points, size = 0.1)
  ) +
  scale_x_log10() +
  facet_grid(Event ~ Region) +
  labs(
    title = paste("FNCS Payouts and Power Points by Event and Region")
  )


###
fcs <- placements %>%
  filter(Match == "Fortnite Champion Series" & Event != "CS Final")

ggplot() +
  geom_point(
    data = fcs, 
    mapping = aes(x = Rank, y = Payout, color = Region, size = 0.2)
  ) +
  geom_point(
    data = fcs, 
    mapping = aes(x = Rank, y = Points, size = 0.1)
  ) +
  scale_x_log10() +
  facet_grid(Event ~ Region) +
  labs(
    title = paste("FNCS Payouts and Power Points by Event and Region - No Final")
  )
ggsave("FNCS No Final.pdf")



###
wc <- placements %>%
  filter(Match == "Fortnite World Cup")

ggplot() +
  geom_point(
    data = wc, 
    mapping = aes(x = Rank, y = Payout, color = Region, size = 0.4)
  ) +
  geom_point(
    data = wc, 
    mapping = aes(x = Rank, y = Points, size = 2)
  ) +
  scale_x_log10() +
  facet_grid(Event ~ Region) +
  labs(
    title = paste("World Cup Qualifier Payouts and Power Points by Event and Region")
  )
ggsave("FWC Qualifiers.png")





