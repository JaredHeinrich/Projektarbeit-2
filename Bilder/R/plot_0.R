library(ggplot2)
library(dplyr)

args <- commandArgs(trailingOnly = TRUE)
output_file <- args[1]

iterations <- 20
data <- read.csv("./R/all.csv")
data <- data %>% filter(type == 0)
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
  scale_x_continuous() +
  labs(
       x = "Größe",
       y = "Durchschnittliche Zeit in µs",
       color = "Modellart",
       fill = "Modellart") +
  theme_minimal()
ggsave(output_file, plot = p, width = 10, height = 6, units = "in")
