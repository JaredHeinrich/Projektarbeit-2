library(ggplot2)
library(dplyr)

args <- commandArgs(trailingOnly = TRUE)
output_file <- args[1]

iterations <- 20
data <- read.csv("./R/all.release.csv")

data <- data %>%
  mutate(time = time / 1e6)

data <- data %>%
  mutate(cpu = cpu / 1e6)

result <- data %>%
  group_by(type, size) %>%
  summarise(
    avg_time = mean(time),
    sd_time = sd(time),
    .groups = 'drop'
  )

result <- result %>%
  mutate(
    ci_lower = avg_time - qt(0.995, df = iterations - 1) * sd_time / sqrt(iterations),
    ci_upper = avg_time + qt(0.995, df = iterations - 1) * sd_time / sqrt(iterations)
  )
p <- ggplot(result, aes(x = size, y = avg_time, color = factor(type))) +
  geom_line() +
  geom_point() +
  geom_errorbar(aes(ymin = ci_lower, ymax = ci_upper)) +
  scale_x_continuous(
    name = "Größe",
  ) +
  scale_y_continuous(
    name = "Durchschnittliche Zeit in Sekunden",
  ) +
  labs(
       color = "Modellart",
       fill = "Modellart") +
  theme_minimal() +
  theme(
    axis.line = element_line(arrow = grid::arrow(length = unit(0.3, "cm")), linewidth = 0.5, color = "black")
  )
ggsave(output_file, plot = p, width = 10, height = 6, units = "in")
