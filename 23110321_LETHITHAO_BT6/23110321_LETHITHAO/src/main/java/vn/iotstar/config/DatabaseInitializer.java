package vn.iotstar.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.core.annotation.Order;
import org.springframework.stereotype.Component;

import vn.iotstar.entity.Category;
import vn.iotstar.entity.User;
import vn.iotstar.entity.Video;
import vn.iotstar.repository.CategoryRepository;
import vn.iotstar.repository.UserRepository;
import vn.iotstar.repository.VideoRepository;

import java.util.Date;

@Component
@Order(1)
public class DatabaseInitializer implements CommandLineRunner {

    @Autowired
    private CategoryRepository categoryRepository;
    
    @Autowired
    private UserRepository userRepository;
    
    @Autowired
    private VideoRepository videoRepository;

    @Override
    public void run(String... args) throws Exception {
        try {
            // Kiểm tra nếu đã có dữ liệu thì không tạo nữa
            if (categoryRepository.count() > 0) {
                System.out.println("📊 Database already has data, skipping initialization");
                return;
            }
            
            System.out.println("🚀 Starting database initialization...");

        // Tạo Categories
        Category tech = new Category();
        tech.setCategoryName("Technology");
        tech.setImages("https://picsum.photos/400/300?random=1");
        tech.setStatus(1);
        tech = categoryRepository.save(tech);

        Category travel = new Category();
        travel.setCategoryName("Travel");
        travel.setImages("https://picsum.photos/400/300?random=2");
        travel.setStatus(1);
        travel = categoryRepository.save(travel);

        Category education = new Category();
        education.setCategoryName("Education");
        education.setImages("https://picsum.photos/400/300?random=3");
        education.setStatus(1);
        education = categoryRepository.save(education);

        Category entertainment = new Category();
        entertainment.setCategoryName("Entertainment");
        entertainment.setImages("https://picsum.photos/400/300?random=4");
        entertainment.setStatus(1);
        entertainment = categoryRepository.save(entertainment);

        Category lifestyle = new Category();
        lifestyle.setCategoryName("Lifestyle");
        lifestyle.setImages("https://picsum.photos/400/300?random=5");
        lifestyle.setStatus(1);
        lifestyle = categoryRepository.save(lifestyle);

        // Tạo Users
        User admin = new User();
        admin.setUsername("admin");
        admin.setPassword("123456");
        admin.setEmail("admin@test.com");
        admin.setFullname("Admin User");
        admin.setPhone("0123456789");
        admin.setRoleid(1);
        admin.setCreateDate(new Date());
        admin.setActive(1);
        userRepository.save(admin);

        User user1 = new User();
        user1.setUsername("user1");
        user1.setPassword("123456");
        user1.setEmail("user1@test.com");
        user1.setFullname("Test User");
        user1.setPhone("0987654321");
        user1.setRoleid(0);
        user1.setCreateDate(new Date());
        user1.setActive(1);
        userRepository.save(user1);

        // Tạo nhiều Videos (25 videos)
        String[] techTitles = {"Video 1", "Video 2", "Video 3", "Video 4", "Video 5", "Video 6", "Video 7", "Video 8"};
        String[] techDescriptions = {
            "Hướng dẫn lập trình Java cơ bản cho người mới bắt đầu",
            "Spring Boot REST API development từ A-Z",
            "ReactJS và modern JavaScript programming",
            "Database design và SQL optimization techniques",
            "Docker containerization cho developers",
            "Git version control và team collaboration",
            "Clean code principles và best practices",
            "Microservices architecture với Spring Cloud"
        };

        String[] travelTitles = {"Video 9", "Video 10", "Video 11", "Video 12", "Video 13", "Video 14", "Video 15", "Video 16"};
        String[] travelDescriptions = {
            "Du lịch Việt Nam - Khám phá miền Bắc xinh đẹp",
            "Backpacking Đông Nam Á với ngân sách tiết kiệm",
            "Cẩm nang du lịch Nhật Bản từ A đến Z",
            "Những điểm đến must-visit ở châu Âu",
            "Street food tour các quốc gia ASEAN",
            "Solo travel tips cho phụ nữa an toàn",
            "Budget travel hacks cho sinh viên",
            "Cultural experiences ở các nước láng giềng"
        };

        String[] educationTitles = {"Video 17", "Video 18", "Video 19", "Video 20", "Video 21", "Video 22", "Video 23"};
        String[] educationDescriptions = {
            "Toán học lớp 12 - Ôn thi THPT Quốc gia",
            "English conversation cho người mới bắt đầu",
            "IELTS Writing strategies và sample essays",
            "Kỹ năng thuyết trình hiệu quả",
            "Time management cho học sinh sinh viên",
            "Critical thinking và problem solving",
            "Study techniques và memory improvement"
        };

        String[] entertainmentTitles = {"Video 24", "Video 25", "Video 26", "Video 27", "Video 28"};
        String[] entertainmentDescriptions = {
            "Top 10 bộ phim hay nhất năm 2024",
            "Nhạc trending TikTok tháng này",
            "Gaming review - Game mobile hot nhất",
            "Anime recommendations cho người mới",
            "K-pop dance cover tutorials"
        };

        String[] lifestyleTitles = {"Video 29", "Video 30", "Video 31", "Video 32", "Video 33", "Video 34", "Video 35"};
        String[] lifestyleDescriptions = {
            "Morning routine của người thành công",
            "Minimalist living - Cuộc sống tối giản",
            "Healthy meal prep cho người bận rộn",
            "Home workout không cần thiết bị",
            "Skincare routine cho mọi loại da",
            "Interior design với budget thấp",
            "Sustainable living tips cho môi trường"
        };

        // Tạo Technology videos
        for (int i = 0; i < techTitles.length; i++) {
            Video video = new Video();
            video.setTitle(techTitles[i]);
            video.setDescription(techDescriptions[i]);
            video.setPoster("https://picsum.photos/480/270?random=" + (100 + i));
            video.setViews((int)(Math.random() * 5000) + 100);
            video.setActive(1);
            video.setCategory(tech);
            videoRepository.save(video);
        }

        // Tạo Travel videos
        for (int i = 0; i < travelTitles.length; i++) {
            Video video = new Video();
            video.setTitle(travelTitles[i]);
            video.setDescription(travelDescriptions[i]);
            video.setPoster("https://picsum.photos/480/270?random=" + (200 + i));
            video.setViews((int)(Math.random() * 3000) + 200);
            video.setActive(1);
            video.setCategory(travel);
            videoRepository.save(video);
        }

        // Tạo Education videos
        for (int i = 0; i < educationTitles.length; i++) {
            Video video = new Video();
            video.setTitle(educationTitles[i]);
            video.setDescription(educationDescriptions[i]);
            video.setPoster("https://picsum.photos/480/270?random=" + (300 + i));
            video.setViews((int)(Math.random() * 4000) + 150);
            video.setActive(1);
            video.setCategory(education);
            videoRepository.save(video);
        }

        // Tạo Entertainment videos
        for (int i = 0; i < entertainmentTitles.length; i++) {
            Video video = new Video();
            video.setTitle(entertainmentTitles[i]);
            video.setDescription(entertainmentDescriptions[i]);
            video.setPoster("https://picsum.photos/480/270?random=" + (400 + i));
            video.setViews((int)(Math.random() * 6000) + 500);
            video.setActive(1);
            video.setCategory(entertainment);
            videoRepository.save(video);
        }

        // Tạo Lifestyle videos
        for (int i = 0; i < lifestyleTitles.length; i++) {
            Video video = new Video();
            video.setTitle(lifestyleTitles[i]);
            video.setDescription(lifestyleDescriptions[i]);
            video.setPoster("https://picsum.photos/480/270?random=" + (500 + i));
            video.setViews((int)(Math.random() * 3500) + 300);
            video.setActive(1);
            video.setCategory(lifestyle);
            videoRepository.save(video);
        }

            System.out.println("✅ Database initialized successfully!");
            System.out.println("📊 Created: " + categoryRepository.count() + " categories, " 
                              + userRepository.count() + " users, " 
                              + videoRepository.count() + " videos");
                              
        } catch (Exception e) {
            System.err.println("❌ Error initializing database: " + e.getMessage());
            e.printStackTrace();
        }
    }
}
