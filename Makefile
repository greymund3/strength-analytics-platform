.PHONY: format format-check lint check-swiftformat check-swiftlint

check-swiftformat:
	@command -v swiftformat >/dev/null || (echo "swiftformat is not installed. Install with: brew install swiftformat" && exit 1)

check-swiftlint:
	@command -v swiftlint >/dev/null || (echo "swiftlint is not installed. Install with: brew install swiftlint" && exit 1)

format: check-swiftformat
	swiftformat --cache ignore strength-analytics-platform

format-check: check-swiftformat
	swiftformat --lint --cache ignore strength-analytics-platform

lint: check-swiftlint
	swiftlint lint --no-cache --config .swiftlint.yml
