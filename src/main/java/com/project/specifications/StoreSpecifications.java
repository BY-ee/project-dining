package com.project.specifications;

import com.project.domain.Store;
import com.project.domain.Theme;
import com.project.domain.Industry;
import com.project.domain.Local;
import com.project.domain.Restaurant;
import com.project.domain.Cafe;
import com.project.domain.Bar;
import org.springframework.data.jpa.domain.Specification;
import jakarta.persistence.criteria.Join;
import jakarta.persistence.criteria.Predicate;
import java.util.ArrayList;
import java.util.List;

public class StoreSpecifications {
    public static Specification<Store> withFilters(String location, String industry, String subCategory, String[] themeArray) {
        return (root, query, criteriaBuilder) -> {
            List<Predicate> predicates = new ArrayList<>();

            // location 필터링
            if (location != null && !location.isEmpty()) {
                Join<Store, Local> localJoin = root.join("local");
                predicates.add(criteriaBuilder.equal(localJoin.get("local"), location));
            }

            // industry 필터링
            if (industry != null && !industry.isEmpty()) {
                Join<Store, Industry> industryJoin = root.join("industry");
                predicates.add(criteriaBuilder.equal(industryJoin.get("industry"), industry));
            }

            // subCategory 필터링 (음식점, 카페, 술집)
            if (subCategory != null && !subCategory.isEmpty()) {
                if (subCategory.equals("음식점")) {
                    Join<Store, Restaurant> restaurantJoin = root.join("restaurant");
                    predicates.add(criteriaBuilder.equal(restaurantJoin.get("restaurant"), subCategory));
                } else if (subCategory.equals("카페")) {
                    Join<Store, Cafe> cafeJoin = root.join("cafe");
                    predicates.add(criteriaBuilder.equal(cafeJoin.get("cafe"), subCategory));
                } else if (subCategory.equals("술집")) {
                    Join<Store, Bar> barJoin = root.join("bar");
                    predicates.add(criteriaBuilder.equal(barJoin.get("bar"), subCategory));
                }
            }

            // themeArray 필터링
            if (themeArray != null && themeArray.length > 0) {
                Join<Store, Theme> themeJoin = root.join("theme");
                predicates.add(themeJoin.get("theme").in((Object[]) themeArray));
            }

            return criteriaBuilder.and(predicates.toArray(new Predicate[0]));
        };
    }
}