import { Text, View, StyleSheet } from "react-native";

export default function homescreen() {
  return (
    <View style={styles.container}>
      <Text>Coming Soon...</Text>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: "center",
    justifyContent: "center",
  },
});