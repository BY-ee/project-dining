# 기본 설정
FROM amazoncorretto:17

# 애플리케이션 빌드
COPY . .
RUN ./gradlew clean build -x test

# 빌드된 JAR 파일 복사
ARG JAR_FILE=build/libs/*.jar
COPY ${JAR_FILE} app.jar

# 환경 변수 파일 복사
COPY application-secret.properties /path/in/container/application-secret.properties

# 애플리케이션 실행
ENTRYPOINT ["java", "-jar", "app.jar"]
